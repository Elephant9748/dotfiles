### Generate default letsencrypt dns-01 for duckdns.org

cerbot

```
sudo certbot certonly --manual --preferred-challenges dns-01 \
    --email bigortm13@tutanota.com --agree-tos -d rpi-brandon.duckdns.org -v
```

Adding TXT record to DuckDNS

```
curl "https://www.duckdns.org/update?domains=rpi-brandon&token=TOKEN-OF-DUCKDNS-USER&txt=VALUE-FROM-certbot-TO-TXT-RECORD&verbose=true"
```

verify TXT record

```
dig +short TXT _acme-challenge.mydomain.duckdns.org
```

Optional DH Parameters

```
sudo openssl dhparam -out /etc/letsencrypt/ssl-dhparams.pem 4096
or
sudo openssl dhparam -out /etc/letsencrypt/ssl-dhparams.pem 2048
```
