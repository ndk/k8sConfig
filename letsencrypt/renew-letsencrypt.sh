#!/bin/bash

if (( "$#" != 1 )) 
then
    echo "No domain name set. Pass a domain name and try again."
exit 1
fi

export CERTBOT_DOMAIN=$1

sudo certbot certonly --manual --manual-auth-hook ./certbot-hook-auth.sh --manual-cleanup-hook ./certbot-hook-cleanup.sh -d $CERTBOT_DOMAIN --manual-public-ip-logging-ok --agree-tos --keep-until-expiring #--force-renewal
