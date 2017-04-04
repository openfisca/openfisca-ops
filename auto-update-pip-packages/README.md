# OpenFisca Operations

## Auto-update pip packages

This script is triggered by Continuous Integration of OpenFisca-France and OpenFisca-Web-API repositories (see their `.travis.yml` respective files).

### Install

You may customize these values to adapt them to your server:
- the Bash variables in `update-openfisca-virtualenv.sh` header (`VENV_ACTIVATE`)

### Configure user permissions

Allow some commands for `openfisca` user to be used with `sudo` without typing any password. As root:

```sh
visudo
```

Then add these lines to the file under the `User privilege specification` section:

```
openfisca ALL=(ALL) NOPASSWD: /bin/systemctl restart openfisca-web-api.service
openfisca ALL=(ALL) NOPASSWD: /bin/systemctl restart legislation-explorer.service
```

This will allow the `update-openfisca-virtualenv.sh` script, which runs as the `openfisca` user, to restart the services.

### Update packages manually

To update pip packages in `openfisca` virtualenv, run:

```sh
cd openfisca-ops/auto-update-pip-packages
./update-openfisca-virtualenv.sh
```
