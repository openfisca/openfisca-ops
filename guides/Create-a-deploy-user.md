# Create a deployment user

## Goal

A deployment user is a UNIX user whose only role is to deploy an application, using a command like:

```sh
ssh deploy-api@fr.openfisca.org
```

This is a good security practice when using Continuous Integration, as it avoids giving third parties a real access to the server.

## Set up

As root:

```sh
adduser --disabled-password --gecos '' --shell /home/deploy-api/deploy-shell.sh deploy-api
```

You can later change the user sheel by editing `/etc/passwd`.

Create an executable file `/home/deploy-api/deploy-shell.sh` containing the following:

```sh
#!/usr/bin/env bash

sudo -u openfisca /home/openfisca/path/to/actual/deploy.sh
```

Finally, as `root`, run:

```sh
visudo
```

And add this line to the file under the `User privilege specification` section:

```
deploy-api ALL=(ALL) NOPASSWD: /home/openfisca/path/to/actual/deploy.sh
``