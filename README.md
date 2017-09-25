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
