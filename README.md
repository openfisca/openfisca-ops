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

The nginx modules are controlled by directives specified in configuration files.
In our case, these configuration files are stored in a directory named after the configured domain name.  
For example: `www.openfisca.fr`'s configuration file is `openfisca-ops/www.openfisca.fr/www.openfisca.fr.conf`

## Services

We use [systemd](https://wiki.debian.org/systemd) services to ensure the continued operation of the OpenFisca related applications (OpenFisca-France [web](https://api.openfisca.fr/) [APIs](https://api-test.openfisca.fr/), [legislation explorer](https://legislation.openfisca.fr/)). `systemd` is available on most recent (> 2015) linux distributions.

The service configuration files are loaded from the `/etc/systemd/system` directory. Symlinks pointing to the source code directory can be used.

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
