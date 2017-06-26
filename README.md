# OpenFisca Operations

This repository contains scripts and config files for deploying OpenFisca on a server.

Nothing secret must be commited to this repository.

## Install

On your server:

```
cd /home/openfisca
git clone git@github.com:openfisca/openfisca-ops.git
```

Each sub-directory has its own README.md file.

## Services

We use [systemd](https://wiki.debian.org/systemd) services to ensure the continued operation of the OpenFisca related applications (OpenFisca-France [web](https://api.openfisca.fr/) [APIs](https://api-test.openfisca.fr/), [legislation explorer](https://legislation.openfisca.fr/)). `systemd` is available on most recent (> 2015) linux distributions.

The service configuration files are loaded from the `/etc/systemd/system` directory. Symlinks pointing to the source code directory can be used.

When you edit one of these files, run this command afterwards so that your changes are taken into account:
```sh
systemctl daemon-reload
```

## Renew SSL certificates

To renew the SSL certificate of an OpenFisca related application, run in `root` the following command, replacing `api-test.openfisca.fr` by the domain that needs a certificate update:
```sh
certbot certonly --webroot -w /tmp/renew-webroot/ -d api-test.openfisca.fr
service nginx reload
```
