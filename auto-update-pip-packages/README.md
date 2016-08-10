# OpenFisca Operations

## Auto-update pip packages

### Install

Install the cron job. As root:
```
cp cron /etc/cron.d/openfisca-auto-update
service cron reload
```

Allow some commands for `openfisca` user to be used with `sudo` without typing any password. As root:
```
visudo
```
Then add these lines to the file under the `User privilege specification` section:
```
openfisca ALL=(ALL) NOPASSWD: /bin/systemctl restart openfisca-web-api.service
openfisca ALL=(ALL) NOPASSWD: /bin/systemctl restart legislation-explorer.service
```
