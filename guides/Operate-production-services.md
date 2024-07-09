# Operate the production services

## Install

To install an instance of the API, see the [dedicated page](guides/Install-API-instance.md).

## Configuration changes

Configuration changes should be tested locally using Vagrant (cf the [dedicated page](guides/Serve-local-API.md)), committed to `openfisca-ops`, then deployed to production by running the Ansible playbook.

No change should be done on the server without updating this repository.

## Servers

### `vps223769.ovh.net`

Provider: OVH.
Usage: legacy server hosting API and Legislation Explorer instances for France and the Country Template.
Replaced by `vps-60ea1664`.

### `vps-60ea1664.openfisca.org`

Provider: OVH.
Usage: server hosting API and Legislation Explorer instances for France and the Country Template.

Deployments are done using the Ansible playbooks of the API (available in `openfisca-ops`) and the [Legislation Explorer](https://github.com/openfisca/legislation-explorer).

## Domains

OpenFisca domains `openfisca.org`, `openfisca.fr` and `openfisca.com` are managed by [Gandi](https://www.gandi.net/).

### Redirections

Some redirections are done at the DNS level. See the "Web Forwarding" tab of Gandi admin UI for each domain:

- `http(s)://www.openfisca.org` -> `https://openfisca.org`
- `http(s)://doc.openfisca.fr` -> `https://openfisca.org/doc/`
- `http(s)://www.openfisca.fr` -> `https://fr.openfisca.org`
- `http(s)://fr.openfisca.org` -> `https://openfisca.org/fr`

> `http(s)://` means that both `http://` and `https://` URLs are redirected.

## Services

### Website

Source code available on <https://github.com/openfisca/openfisca.org/>

It is deployed to <https://openfisca.org/> by continuous deployment provided by CircleCI.

It is hosted by GitHub Pages.

The [settings](https://github.com/openfisca/openfisca.org/settings/pages) of the GitHub repository defines a custom domain name (`openfisca.org`), and the registrar has been set up to point the `A` and `AAAA` DNS records to GitHub Pages' servers.

### Documentation

Source code available on <https://github.com/openfisca/openfisca-doc/>

It is deployed to <https://openfisca.org/doc/>.

The CD on this repository generates the HTML from the documentation and adds the built content to the `doc` directory of the [openfisca.org `gh-pages` branch](https://github.com/openfisca/openfisca.org/tree/gh-pages) through the `deploy` GitHub Actions workflow.

### API - demo

Public URL: <https://api.demo.openfisca.org/latest>.

Source code available on <https://github.com/openfisca/openfisca-core>.

This instance is configured to use the [Country Template](https://github.com/openfisca/country-template).

This instance is deployed using the Ansible playbook defined in `openfisca-ops`.

This playbook offers an auto-update feature that installs the latest API version and the latest country package on a regular basis.
To update the instance manually, run the Ansible playbook with `ansible-playbook --inventory ansible/inventories/api.demo.openfisca.org.yml ansible/site.yml`.

This instance is hosted on the `vps-60ea1664.openfisca.org` server.

To restart the service, log in as `root` to the server:

```bash
systemctl restart openfisca-web-api-demo.service
```

To read the logs, log in as `root` to the server:

```bash
journalctl -u openfisca-web-api-demo.service
```

### API - France

Public URL: <https://api.fr.openfisca.org/latest>.

Source code available on <https://github.com/openfisca/openfisca-core>.

This instance is configured to use [OpenFisca-France](https://github.com/openfisca/openfisca-france).

This instance is deployed using the Ansible playbook defined in `openfisca-ops`.

This playbook offers an auto-update feature that installs the latest API version and the latest country package on a regular basis.
To update the instance manually, run the Ansible playbook with `ansible-playbook --inventory ansible/inventories/api.fr.openfisca.org.yml ansible/site.yml`.

This instance is hosted on the `vps-60ea1664.openfisca.org` server.

To restart the service, log in as `root` to the server:

```bash
systemctl restart openfisca-web-api-fr.service
```

To read the logs, log in as `root` to the server:

```bash
journalctl -u openfisca-web-api-fr.service
```

### Legislation Explorer - demo

Public URL: <https://legislation.demo.openfisca.org/>.

Source code available on <https://github.com/openfisca/legislation-explorer>.

This instance is configured to call the demo API.

This instance is deployed using the Ansible playbook defined in [Legislation Explorer](https://github.com/openfisca/legislation-explorer).

To update the instance manually, run the Ansible playbook.

The related Ansible inventory file is `ops/ansible/legislation.demo.openfisca.org.yml`.

This instance is hosted on the `vps-60ea1664.openfisca.org` server.

To restart the service, log in as `root` to the server:

```bash
systemctl restart legislation-explorer-demo.service
```

To read the logs, log in as `root` to the server:

```bash
journalctl -u legislation-explorer-demo.service
```

### Legislation Explorer - France

Public URL: <https://legislation.fr.openfisca.org/>.

Source code available on <https://github.com/openfisca/legislation-explorer>.

This instance is configured to call the API for OpenFisca-France.

This instance is deployed using the Ansible playbook defined in [Legislation Explorer](https://github.com/openfisca/legislation-explorer).

To update the instance manually, run the Ansible playbook.

The related Ansible inventory file is `ops/ansible/legislation.fr.openfisca.org.yml`.

This instance is hosted on the `vps-60ea1664.openfisca.org` server.

To restart the service, log in as `root` to the server:

```bash
systemctl restart legislation-explorer-fr.service
```

To read the logs, log in as `root` to the server:

```bash
journalctl -u legislation-explorer-fr.service
```

## SSL certificates

SSL certificates are managed by the Ansible playbooks using [Certbot](https://certbot.eff.org/), a client for [Let's Encrypt](https://letsencrypt.org/).

They are renewed automatically thanks to the cron job defined by Certbot in `/etc/cron.d/certbot`.

Manual renewal should never have to be done, however to do so, connect to the server as `root` and do:

```bash
certbot renew
```

### `fr.openfisca.org`

This legacy subdomain redirects to `openfisca.org/fr` through an HTTP redirect handled by the registrar.
