# OpenFisca Operations

## Auto-update pip packages

[`deploy-shell.sh`](deploy-shell.sh) is triggered by the Continuous Integration of [OpenFisca-France](https://github.com/openfisca/openfisca-france/blob/master/.travis.yml) and [OpenFisca-Web-API]https://github.com/openfisca/openfisca-web-api/blob/master/.travis.yml).

### Install

You may customize variables and paths in [`deploy-shell.sh`](deploy-shell.sh) and [`update-openfisca-virtualenv.sh`](update-openfisca-virtualenv.sh) to adapt them to your server.

### Create Unix deployment users

As root:

```sh
adduser --disabled-password --gecos '' --shell ~openfisca/openfisca-ops/auto-update-pip-packages/deploy-shell.sh deploy-api
```

### Configure user permissions

Allow some commands for `openfisca`, `deploy-api` and `deploy-new-api` Unix users to be used with `sudo` without typing any password. As root:

```sh
visudo
```

Add these lines to the file under the `User privilege specification` section:

```
openfisca ALL=(ALL) NOPASSWD: /bin/systemctl restart openfisca-web-api.service
openfisca ALL=(ALL) NOPASSWD: /bin/systemctl restart legislation-explorer.service
openfisca ALL=(ALL) NOPASSWD: /bin/systemctl restart openfisca-web-api-new.service

deploy-api ALL=(ALL) NOPASSWD: /home/openfisca/openfisca-ops/auto-update-pip-packages/update-openfisca-virtualenv.sh
```
