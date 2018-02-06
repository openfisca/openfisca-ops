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

We use [systemd](https://wiki.debian.org/systemd) services to ensure the continued operation of the OpenFisca related applications (OpenFisca-France [web API](https://fr.openfisca.org/api/v18), [legislation explorer](https://legislation.openfisca.fr/)). `systemd` is available on most recent (> 2015) linux distributions.

The service configuration files are loaded from the `/etc/systemd/system` directory.  
In order to keep these files versionned, we use symlinks from this directory towards the server local clone of this repository.


When you edit one of these files, run this command afterwards so that your changes are taken into account:
```sh
systemctl daemon-reload
```

## Set up a SSL certificate

See the [dedicated page](guides/Set-up-SSL.md).

## Renew SSL certificates

To renew the SSL certificate of an OpenFisca related application, run in `root` the following command, replacing `fr.openfisca.org` by the domain that needs a certificate update:
```sh
certbot certonly --webroot -w /tmp/renew-webroot/ -d fr.openfisca.org
service nginx reload
```
## Serve a new version of the public api

### To update the current major version being served
- connect to the server
- got to the virtualenv (`cd /home/openfisca/virtualenvs/api-frxx`)
- activate the virtualenv (`source bin/activate`)
- update the openfisca version 
- run the instructions in the `deploy.sh` file


### To serve a new version :
- on `openfisca-ops`, in a new branch, create a new repo with the config files
- connect to the server
- pull the new `openfisca-ops`
- got to the virtualenv (`cd /home/openfisca/virtualenvs`)
- create the new virtualenv (`virtualenv api-frxx`)
- enter the virtualenv (`cd api-frxx`)
- activate the virtualenv (`source bin/activate`)
- run the instructions in the `deploy.sh` file
- go to `/etc/systemd/system`
- create a new service with a symlink 
- reload the daemon 
