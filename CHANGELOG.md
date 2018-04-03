# Changelog

### 0.6.0 [#40](https://github.com/openfisca/openfisca-ops/pull/40)

- Host the legislation explorer on fr.openfisca.org/legislation

On repo :
- In order to redirect traffic : modified openfisca-ops/fr.openfisca.org/fr.openfisca.org.conf
- In order to have the service for the legislation explorer on openfisca-ops : created openfisca-ops/fr.openfisca.org/legislation-explorer/legislation-explorer.service

On server :
- created symlink legislation-explorer.service to home/openfisca/openfisca-ops/fr.openfisca.org/legislation-explorer/legislation-explorer.service

### 0.5.0 [#33](https://github.com/openfisca/openfisca-ops/pull/33)

- Redirect traffic from openfisca.fr to fr.openfisca.org's new website

On repo :
- modified openfisca-ops/www.openfisca.fr/www.openfisca.fr.conf

On server :
- Replaced file home/openfisca/production-configs/www.openfisca.fr/config/www.openfisca.fr.conf with symlink to /home/openfisca/openfisca-ops/www.openfisca.fr/www.openfisca.fr.conf
