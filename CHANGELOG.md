# Changelog

## Update and clean up debian packages
  - Remove `yarn`, `python-magic`, `mongodb`,`mongodb-dev`, `mongodb-clients`, `docker-engine`, 

  - stopped & removed calculette-impots-web-api.service (kept service in `old` directory on openfisca-ops)
  - stopped & removed calculette-impots-web-explorer.service (kept service in `old` directory on openfisca-ops)
  - stopped & removed openfisca-web-site.service (kept service in `old` directory on openfisca-ops)
  - stopped & removed dotenv.service


FYI : 
message when updating extlinux
│                                                                                                                             │ 
      │ No bootloader integration code anymore                                                                                      │ 
      │                                                                                                                             │ 
      │ The extlinux package does not ship bootloader integration anymore.                                                          │ 
      │                                                                                                                             │ 
      │ If you are upgrading to this version of EXTLINUX your system will not boot any longer if EXTLINUX was the only configured   │ 
      │ bootloader. Please install GRUB.       
    
## Use a `.env` to configure the Legislation explorer
  - Created a symlink `/home/openfisca/legislation-explorer/.env` -> `/home/openfisca/openfisca-ops/fr.openfisca.org/legislation-explorer/.env`

## Serve `fr.openfisca.org/api/v22`
  - Created a new virtualenv in `/home/openfisca/virtualenvs/api-fr22`

### 0.8.3 [#52](https://github.com/openfisca/openfisca-ops/pull/52)

* Reduce the number of workers on the API instances so the server won't overload.

### 0.8.2 [#44](https://github.com/openfisca/openfisca-ops/pull/44)

* Remove deployment script for `fr.openfisca.org`

### 0.8.1 [#34](https://github.com/openfisca/openfisca-ops/pull/34)

* Remove [non-breaking spaces](https://en.wikipedia.org/wiki/Non-breaking_space) from [changelog](CHANGELOG.md)
* Improve formatting
* Fix formatting bugs

## 0.8.0 [#43](https://github.com/openfisca/openfisca-ops/pull/43)

* Serve `fr.openfisca.org/api/v21`
* Details:
  - On repo:
      - Created configuration files in `openfisca-ops/fr.openfisca.org/api/v21`
  - On server:
      - Created a new virtualenv in `/home/openfisca/virtualenvs/api-fr21` following [these steps](https://github.com/openfisca/openfisca-ops/tree/af6b38d21ccda7bbe7162ee8563e4a8d5649baf1#to-serve-a-new-version-)

## 0.7.0 [#41](https://github.com/openfisca/openfisca-ops/pull/41)

* Redirect traffic from `legislation.openfisca.fr` to `fr.openfisca.org/legislation`
* Details:
  - On repo:
      - In order to have the configuration `legislation.openfisca.fr` on `openfisca-ops` : created `openfisca-ops/legislation.openfisca.fr/legislation.openfisca.conf with the redirection`
  - On server:
      - Replaced symlink `for nginx/sites-available/legislation.openfisca.fr.conf`to file `openfisca-ops/legislation.openfisca.fr/legislation.openfisca.conf`

## 0.6.0 [#40](https://github.com/openfisca/openfisca-ops/pull/40)

* Host the legislation explorer on `fr.openfisca.org/legislation`
* Details:
  - On repo:
      - In order to redirect traffic: modified `openfisca-ops/fr.openfisca.org/fr.openfisca.org.conf`
      - In order to have the service for the legislation explorer on `openfisca-ops`: created `openfisca-ops/fr.openfisca.org/legislation-explorer/legislation-explorer.service`
  - On server:
      - Created symlink `legislation-explorer.service` to `home/openfisca/openfisca-ops/fr.openfisca.org/legislation-explorer/legislation-explorer.service`

## 0.5.0 [#33](https://github.com/openfisca/openfisca-ops/pull/33)

* Redirect traffic from openfisca.fr to fr.openfisca.org's new website
* Details:
  - On repo:
      - Modified `openfisca-ops/www.openfisca.fr/www.openfisca.fr.conf`
  - On server:
      - Replaced file `/home/openfisca/production-configs/www.openfisca.fr/config/www.openfisca.fr.conf` with symlink to `/home/openfisca/openfisca-ops/www.openfisca.fr/www.openfisca.fr.conf`
