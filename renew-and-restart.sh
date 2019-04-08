#!/bin/bash

if (( "$#" < 1 ))
then
    echo "No domain name set. Pass a domain name and try again."
    echo "Usage: ./renew-and-restart.sh domain.name"
exit 1
fi

export CERTBOT_DOMAIN=$1

# get this script's directory (works on Linux, OSX, etc.)
# See: https://stackoverflow.com/a/17744637
thisScriptsDir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
pushd $thisScriptsDir/letsencrypt

# renew certs:
echo " -> Renewing certificicates..."
./gen-certs.sh $CERTBOT_DOMAIN renew

# update secrets:
echo " -> Updating Kubernetes secrets..."
./gen-secrets.sh $CERTBOT_DOMAIN

# restart ingress:
echo " -> Restarting the ingress(es)..."
./ingress-restart.sh


popd
