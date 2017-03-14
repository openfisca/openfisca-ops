# OpenFisca Operations

## Auto-update ssl certificates

### Cron

Make sure you have the cerbot cron file in /etc/cron.d/certbot with this inside :

```
0 */12 * * * root test -x /usr/bin/certbot -a \! -d /run/systemd/system && perl -e 'sleep int(rand(3600))' && certbot -q renew
```

### certificates renewal file configuration

We obtain the certificate with the command certbot --certonly
To renew automaticaly your certificate without stop web service you must edit the certificate renewal file to specify the webroot renewal methos and his path,
for example, we edit the renewal file for www.openfisca.fr domain in /etc/letsencrypt/renewal/www.openfisca.fr

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
