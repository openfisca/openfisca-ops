# Renew SSL certificates

## Manual renewal

To renew the SSL certificate of an OpenFisca related application, run the following commands, replacing `fr.openfisca.org` by the domain that needs a certificate update:

```sh
sudo /home/openfisca/.pyenv/shims/certbot certonly --webroot -w /tmp/renew-webroot/ -d fr.openfisca.org
sudo service nginx reload
```

To renew all SSL certificates at once, run the following commands:

```sh
sudo /home/openfisca/.pyenv/shims/certbot -q renew
sudo service nginx reload
```

## Automatic renewal

Make sure you have the cerbot cron file in `/etc/cron.d/certbot` with this inside, so to renew certificates every twelve hours:

```sh
0 */12 * * * root /home/openfisca/.pyenv/shims/certbot -q renew
```

### Certificates renewal file configuration

To renew automatically your certificate without stopping the Nginx server, you must edit the certificate renewal file to specify the webroot renewal method and its path.

For example, we edit the renewal file for `www.openfisca.fr` domain in `/etc/letsencrypt/renewal/www.openfisca.fr`

```diff
# renew_before_expiry = 30 days
version = 0.27.1
cert = /etc/letsencrypt/live/www.openfisca.fr/cert.pem
privkey = /etc/letsencrypt/live/www.openfisca.fr/privkey.pem
chain = /etc/letsencrypt/live/www.openfisca.fr/chain.pem
fullchain = /etc/letsencrypt/live/www.openfisca.fr/fullchain.pem

# Options used in the renewal process
[renewalparams]
account = 6892514f278f44be6c61c8d3899819f4
+authenticator = webroot
+webroot_path = /tmp/renew-webroot
server = https://acme-v02.api.letsencrypt.org/directory
[[webroot_map]]
+www.openfisca.fr = /tmp/renew-webroot
```
