# OpenFisca Operations

## Auto-update SSL certificates

### Cron

Make sure you have the cerbot cron file in `/etc/cron.d/certbot` with this inside

```
0 */12 * * * root test -x /usr/bin/certbot -a \! -d /run/systemd/system && perl -e 'sleep int(rand(3600))' && certbot -q renew
```

### Certificates renewal file configuration

We obtain the certificate with the command 

```bash
certbot --certonly
```

To renew automatically your certificate without stopping nginx server you must edit the certificate renewal file to specify the webroot renewal method and his path.
For example, we edit the renewal file for `www.openfisca.fr` domain in `/etc/letsencrypt/renewal/www.openfisca.fr`

```diff
# renew_before_expiry = 30 days
version = 0.9.3
cert = /etc/letsencrypt/live/www.openfisca.fr/cert.pem
privkey = /etc/letsencrypt/live/www.openfisca.fr/privkey.pem
chain = /etc/letsencrypt/live/www.openfisca.fr/chain.pem
fullchain = /etc/letsencrypt/live/www.openfisca.fr/fullchain.pem

# Options used in the renewal process
[renewalparams]
+authenticator = webroot
installer = None
account = 6892514f278f44be6c61c8d3899819f4
+[[webroot_map]]
+www.openfisca.fr = /var/www/html
```
