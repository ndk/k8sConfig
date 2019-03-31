#!/bin/bash

# These env vars are automatically set:
echo $CERTBOT_DOMAIN
echo $CERTBOT_VALIDATION
echo $CERTBOT_TOKEN

#echo $CERTBOT_VALIDATION > /var/www/htdocs/.well-known/acme-challenge/$CERTBOT_TOKEN
cat ./ingress-letsencrypt.template.yaml | envsubst | microk8s.kubectl apply -f -
