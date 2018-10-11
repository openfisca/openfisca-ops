# OpenFisca Operations

This repository contains scripts and config files for deploying OpenFisca on a server.

Nothing secret must be commited to this repository.

## Install

On your server:

```
cd /home/openfisca
git clone git@github.com:openfisca/openfisca-ops.git
```

For more information on `auto-update` sub-directories, please see their own README.md files.

## Server configuration

The nginx configuration files are loaded from the `/etc/nginx/sites-available` directory.

In order to keep these files versionned, we use symlinks from this directory towards the server local clone of this repository.

When you edit one of these files, run this command afterwards so that your changes are taken into account:

```sh
service nginx reload
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

See the [dedicated page](guides/Set-up-SSL.md).

## Create a deploy user

See the [dedicated page](guides/Create-a-deploy-user.md).

## Renew SSL certificates

To renew the SSL certificate of an OpenFisca related application, run the following commands, replacing `fr.openfisca.org` by the domain that needs a certificate update:

```sh
sudo certbot certonly --webroot -w /tmp/renew-webroot/ -d fr.openfisca.org
sudo service nginx reload
```

To renew all SSL certificates at once, run the following commands:

```sh
sudo certbot renew
sudo service nginx reload
```

## Serve a new version of the public api

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
  - create the new virtualenv (`virtualenv api-frxx`)
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

## Passwords

Access to shared services (`OVH`, `Twitter`, etc.) must be done through individual accounts, to which the management is delegated.

However, some systems do not support delegation, or it can sometimes be helpful to get administrator access to master accounts.

Therefore, a database containing all the necessary passwords is accessible.

### Accessing the passwords database

* Install [KeePassX](https://www.keepassx.org/downloads)
* Download the [database](openfisca.kdbx)
* Request key and password on the [#of-ops](https://openfisca.slack.com) channel, or by [email](mailto:contact@openfisca.org)

The underlying intention is to reduce the risk of loss of control over password-protected components and to provide, in the long-term, a standard access to OpenFisca’s services and accounts. That in order to improve delivery, fail safety and resilience.

Do not transmit key and password through the same channel. Password must be communicated orally, and key should be transmitted either by physical transfer (USB key, etc.) or electronically, in which case you’ll have to encrypt it before sending.

Currently, access to both key and password are granted to [@Anna-Livia](https://github.com/Anna-Livia), [@MattiSG](https://github.com/MattiSG), [@maukoquiroga](https://github.com/maukoquiroga) and [@sandcha](https://github.com/sandcha). This is expected to change as the community sees the need.
