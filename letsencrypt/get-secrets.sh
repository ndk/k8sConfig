#!/bin/bash
  
if (( "$#" < 1 ))
then
    echo "No domain name set. Pass a domain name and try again."
    echo "Usage: ./gen-secrets.sh domain.name"
exit 1
fi

export CERTBOT_DOMAIN=$1

# secret name cannot contain '.', '_', etc.
# e.g. "tls-secret-nonprod-rexsystems-co-uk"
cert_name="tls-secret-"$(echo $CERTBOT_DOMAIN | sed -e 's/[_\.]/-/g')
#echo $cert_name

sudo microk8s.kubectl create secret tls $cert_name --cert /etc/letsencrypt/live/$CERTBOT_DOMAIN/fullchain.pem --key /etc/letsencrypt/live/$CERTBOT_DOMAIN/privkey.pem
