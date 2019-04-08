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

if [ $? -ne 0 ]; then
    echo "Non-zero error code!"
    echo "OK, let's attempt to update exiting Kubernetes secret..."
    # Nice! See: https://stackoverflow.com/a/45881259/395974
    sudo microk8s.kubectl create secret tls $cert_name --cert /etc/letsencrypt/live/$CERTBOT_DOMAIN/fullchain.pem --key /etc/letsencrypt/live/$CERTBOT_DOMAIN/privkey.pem --dry-run --save-config=false -o yaml | microk8s.kubectl apply -f -
fi
