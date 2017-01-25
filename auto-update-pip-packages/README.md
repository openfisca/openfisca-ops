# OpenFisca Operations

## Auto-update pip packages

### Install

Install the cron job. As root:

```bash
# cp cron /etc/cron.d/openfisca-auto-update-pip-packages
# systemctl restart cron
```

> The cron file and the `update-openfisca-virtualenv.sh` script may be customized to adapt the file path.

### Configure user permissions

Allow some commands for `openfisca` user to be used with `sudo` without typing any password. As root:

```bash
# visudo
```

Then add these lines to the file under the `User privilege specification` section:

```
openfisca ALL=(ALL) NOPASSWD: /bin/systemctl restart openfisca-web-api.service
openfisca ALL=(ALL) NOPASSWD: /bin/systemctl restart legislation-explorer.service
```

This will allow the `update-openfisca-virtualenv.sh` script, which runs as the `openfisca` user, to restart the services.