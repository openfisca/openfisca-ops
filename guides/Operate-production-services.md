# Operate the production services

## Install

To install an instance of the API, see the [dedicated page](guides/Install-API-instance.md).

## Configuration changes

Configuration changes should be tested locally using Vagrant (cf the [dedicated page](guides/Serve-local-API.md)), committed to `openfisca-ops`, then deployed to production by running the Ansible playbook.

No change should be done on the server without updating this repository.

## Servers

The following servers are provided by [OVH](https://www.ovh.com/).

### `vps223769`

Legacy server hosting API and Legislation Explorer instances for France and the Country Template.
Replaced by `vps-60ea1664`.

### `vps-60ea1664`

Server hosting API and Legislation Explorer instances for France and the Country Template.

Deployments are done using the Ansible playbooks of the API (available in `openfisca-ops`) and the [Legislation Explorer](https://github.com/openfisca/legislation-explorer).

## Domains

OpenFisca domains (`openfisca.org`, `openfisca.fr` and `openfisca.com`) are managed by [Gandi](https://www.gandi.net/).

### Redirections

Some redirections are done at the DNS level. See the "Web Forwarding" tab of Gandi admin UI for each domain:

- `http(s)://www.openfisca.org` -> `https://openfisca.org`
- `http(s)://doc.openfisca.fr` -> `https://openfisca.org/doc/`
- `http(s)://www.openfisca.fr` -> `https://fr.openfisca.org`

> `http(s)://` means that both `http://` and `https://` URLs are redirected.

## Services

### `fr.openfisca.org`

Source code: <https://github.com/openfisca/fr.openfisca.org>

The website for France is a static web application hosted at [Netlify](https://www.netlify.com/).

The domain `fr.openfisca.org` is configured to point to Netlify.

Each commit to `master` is deployed automatically by Netlify.

The `_redirects` file, thanks to [Netlify redirects](https://docs.netlify.com/routing/redirects/), keeps backward compatibility with the legacy URLs <https://fr.openfisca.org/api/latest> and <https://fr.openfisca.org/legislation>.

### Documentation

Source code: <https://github.com/openfisca/openfisca-doc/>

It is deployed to <https://openfisca.org/doc/>.

It is hosted at [Netlify](https://www.netlify.com/).

### API

The API instances are hosted on the OVH server.

Instances:

- Demo (uses the [Country Template](https://github.com/openfisca/country-template)): <https://api.demo.openfisca.org/latest>
- France (uses [OpenFisca-France](https://github.com/openfisca/openfisca-france)): <https://api.fr.openfisca.org/latest>

### Legislation Explorer

Instances:

- Demo: <https://legislation.demo.openfisca.org/>
- France: <https://legislation.fr.openfisca.org/>

## SSL certificates

SSL certificates are managed by the Ansible playbooks using [Certbot](https://certbot.eff.org/), a client for [Let's Encrypt](https://letsencrypt.org/).

They are renewed automatically thanks to the cron job defined by Certbot in `/etc/cron.d/certbot`.

Manual renewal should never have to be done, however to do so, connect to the server as `root` and do:

```bash
certbot renew
```
