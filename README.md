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

Access to shared services (OVH, PyPI, Mastodon…) must be done through individual accounts, to which management is delegated.

However, some systems do not support delegation, or it can sometimes be helpful to get administrator access to master accounts.

A database containing all passwords for OpenFisca services is maintained by the Association. It is accessible to members of the Board, who can delegate access to third parties for a specific mission. Every access delegation is listed in the minutes of the Board decisions.

The underlying intention is to reduce the risk of loss of control over password-protected components and to provide, in the long-term, a standard access to OpenFisca’s services and accounts. This is in order to improve delivery, fail safety and resilience.

### Accessing the passwords database

If you believe you need administrator access to an OpenFisca service to fulfil a mission, open a pull request on this repository to add yourself in the access ledger below. Explain in the description which services you need access to, and why you need it. The admin team will review your request and get back to you.

If you have been granted permission to access the passwords database:

1. Download the passwords database on [`cloud.openfisca.org`](https://cloud.openfisca.org).
2. Install [KeePassXC](https://keepassxc.org/download).
3. Obtain the password and key from the Board.

### Providing access to the passwords database

Do not transmit key and password through the same channel. Password must be communicated orally, and key should be transmitted either by physical transfer (USB key, etc.) or electronically, in which case you’ll have to encrypt it before sending.

### Historical access ledger

Historically a password database was provided in this repository, but this is now deprecated. This legacy system is still reachable thanks to Git history and, while passwords are not updated there, some older services might still be reachable through the credentials listed there. Access to that legacy passwords database was granted to:

- [@Anna-Livia](https://github.com/Anna-Livia)
- [@cbenz](https://github.com/cbenz)
- [@MattiSG](https://github.com/MattiSG)
- [@maukoquiroga](https://github.com/maukoquiroga)
- [@Morendil](https://github.com/morendil)
- [@sandcha](https://github.com/sandcha)
- [@clementbiron](https://github.com/clementbiron/)
