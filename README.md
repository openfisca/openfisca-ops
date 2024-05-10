# OpenFisca Operations

This repository contains scripts and config files for deploying OpenFisca on a server.

No secret must be committed to this repository.

## Install the OpenFisca Web API on a virtual machine for development purposes

If you want to make use of the OpenFisca Web API without handling its installation, for example if you are building a client application, the easiest is to [set up a virtual machine](guides/Serve-local-API.md).

## Install the OpenFisca Web API on a server

See the [dedicated page](guides/Install-API-instance.md).

## Operate the production instance of OpenFisca France Web API

See the [dedicated page](guides/Operate-production-France-API.md).

## Passwords

Access to shared services (OVH, PyPI, X…) must be done through individual accounts, to which management is delegated.

However, some systems do not support delegation, or it can sometimes be helpful to get administrator access to master accounts.

Therefore, a database containing all the necessary passwords is accessible.

### Accessing the passwords database

- Install [KeePassX](https://www.keepassx.org/downloads)
- Download the [database](openfisca.kdbx)
- Request key and password on the [#of-ops](https://openfisca.slack.com) channel, or by [email](mailto:contact@openfisca.org)

The underlying intention is to reduce the risk of loss of control over password-protected components and to provide, in the long-term, a standard access to OpenFisca’s services and accounts. That in order to improve delivery, fail safety and resilience.

Do not transmit key and password through the same channel. Password must be communicated orally, and key should be transmitted either by physical transfer (USB key, etc.) or electronically, in which case you’ll have to encrypt it before sending.

Currently, access to both key and password are granted to [@Anna-Livia](https://github.com/Anna-Livia), [@cbenz](https://github.com/cbenz), [@MattiSG](https://github.com/MattiSG), [@maukoquiroga](https://github.com/maukoquiroga), [@Morendil](https://github.com/morendil), [@sandcha](https://github.com/sandcha) and [@clementbiron](https://github.com/clementbiron/). This is expected to change as the community sees the need.
