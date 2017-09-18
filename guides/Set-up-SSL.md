# Set up HTTPS on a domain name

To handle `HTTPS` on a website, we need an up-to-date SSL **certificate**. For `openfisca.fr` and `openfisca.org`, we use [Let’s Encrypt](https://letsencrypt.org/) as a certificate provider.

Note that we need one certificate per subdomain:
- `openfisca.org` and `fr.openfisca.org` use **two different** certificates.
- `fr.openfisca.org` and `fr.openfisca.org/api/` use **the same** certificate, even if they are different applications.

The following instructions will help you set up a SSL certificate, taking `fr.openfisca.org` as an example.

## 1. Expose `./well-known` in HTTP

To get our certificate from Let's Encrypt, we need to prove that we are indeed the owner of `fr.openfisca.org`. To do so, we need to expose the content of a static directory in **HTTP**. This is done by [adding these lines](https://github.com/openfisca/openfisca-ops/blob/4524f707ab1123258621d2e16dc0df20a9140e73/fr.openfisca.org/fr.openfisca.org.conf#L5-L7) in the NGINX configuration :

```
location /.well-known {
    root /tmp/renew-webroot;
}
```

## 2. Get the certificate

To get the certificate, run :

```sh
certbot certonly --webroot -w /tmp/renew-webroot/ -d fr.openfisca.org
```

If this suceeds, certificates are generated in the `/etc/letsencrypt/live/fr.openfisca.org/` directory.

## 3. Set SSL in NGINX

To allow HTTPS for a domain name, [edit the NGINX configuration](https://github.com/openfisca/openfisca-ops/blob/4524f707ab1123258621d2e16dc0df20a9140e73/fr.openfisca.org/fr.openfisca.org.conf#L14-L19) file to reference the generated certificate:

```
server {
        listen 443 ssl;
        server_name fr.openfisca.org;

        ssl_certificate /etc/letsencrypt/live/fr.openfisca.org/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/fr.openfisca.org/privkey.pem;

    location / {
        ...
    }

} 
```

Then run `service nginx reload` to take your changes into account.

At this point, `https://fr.openfisca.org` should work! Make sure it does before going further.

> To do so, just type https://fr.openfisca.org in your browser, without forgetting the **s** at the end of **https**, and check that the page loads without any certificate error.

## 4. Redirect HTTP traffic to HTTPS

If you are **serving an API**, be careful. This is a breaking change: if some users are using your API in HTTP, and haven't set up their client to follow `301` redirections, their code will break.

Make sure to give enough time to your users to adapt before enforcing HTTPS, and of course, make sure to update the common OpenFisca tools that consume the API.

If you are just serving a website, the redirection should be transparent for users.

To enforce HTTPS, just [add these lines](https://github.com/openfisca/openfisca-ops/blob/4524f707ab1123258621d2e16dc0df20a9140e73/fr.openfisca.org/fr.openfisca.org.conf#L9-L11) to your **HTTP** configuration in the NGINX configuration file:

```
location / {
        return 301 https://$server_name$request_uri;
}
```
