# Operate the production instance of OpenFisca France Web API

The production instance of OpenFisca France Web API is deployed to <https://fr.openfisca.org/api/latest>.

## Install

On your server:

```sh
cd /home/openfisca
git clone git@github.com:openfisca/openfisca-ops.git
```

For more information on `auto-update` sub-directories, please see their own README.md files.

## Server configuration

The nginx configuration files are loaded from the `/etc/nginx/sites-available` directory.

In order to keep these files versionned, we use symlinks from this directory towards the server local clone of this repository.

When you edit one of these files, run this command afterwards so that your changes are taken into account:

```sh
sudo service nginx reload
```

## Services

We use [systemd](https://wiki.debian.org/systemd) services to ensure the continued operation of the OpenFisca related applications (OpenFisca-France [web API](https://fr.openfisca.org/api/v24), [legislation explorer](https://legislation.openfisca.fr/)). `systemd` is available on most recent (> 2015) linux distributions.

The service configuration files are loaded from the `/etc/systemd/system` directory.

In order to keep these files versionned, we use symlinks from this directory towards the server local clone of this repository.

When you edit one of these files, run this command afterwards so that your changes are taken into account:

```sh
systemctl daemon-reload
```

To make sure the user `openfisca` is allowed to restart a service in order to redeploy it, log in and run:

```sh
sudo visudo
```

Add a line like the following to the file under the `User privilege specification` section:

```
openfisca ALL=(ALL) NOPASSWD: /bin/systemctl restart legislation-explorer.service
```

## Set up a SSL certificate

See the [dedicated page](Set-up-SSL.md).

## Create a deploy user

See the [dedicated page](Create-a-deploy-user.md).

## Renew SSL certificates

See the [dedicated page](Renew-SSL-certificates.md).

## Serve a new version of the public API

### To update the latest major version being served

Run `ssh deploy-api@fr.openfisca.org`

This automatically runs the `fr.openfisca.org/api/deploy-latest.sh` script.

### To serve a new version

- on `openfisca-ops`, in a new branch, create a new repo with the config files
- update the `fr.openfisca.org/api/deploy-latest.sh` symlink to point to the latest deploy script:
  - `cd fr.openfisca.org/api && rm deploy-latest.sh && ln -s ./vxx/deploy.sh deploy-latest.sh`
- connect to the server
  - run `sudo su - openfisca`
  - pull the new `openfisca-ops`
  - get to the virtualenvs folder (`cd /home/openfisca/virtualenvs`)
  - create the new virtualenv (`virtualenv --python /home/openfisca/.pyenv/shims/python3.7 api-frxx`)
  - run `exit` twice
- connect to the server
  - run `sudo su - root`
  - go to `/etc/systemd/system`
  - create a new service with a symlink
  - run `sudo visudo` and authorize openfisca to reload the new service.
  - reload the daemon
  - run `sudo systemctl enable openfisca-web-api-frxx.service` so that the service automatically starts when the OS reboots
  - run `exit` twice
- run `ssh deploy-api@fr.openfisca.org`
