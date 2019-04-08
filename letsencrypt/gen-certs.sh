#!/bin/bash

if (( "$#" < 1 )) 
then
    echo "No domain name set. Pass a domain name and try again."
    echo "Usage: ./gen-certs.sh domain.name [\"renew\"]"
exit 1
fi

SHOULD_RENEW=$2

export CERTBOT_DOMAIN=$1

if [ "$SHOULD_RENEW" == "renew" ]; then
	echo "...Renewing existing certificate..."
	cmd="sudo certbot certonly --manual --manual-auth-hook ./certbot-hook-auth.sh --manual-cleanup-hook ./certbot-hook-cleanup.sh -d $CERTBOT_DOMAIN --manual-public-ip-logging-ok --agree-tos --keep-until-expiring --force-renewal"
	echo $cmd
	result=`$cmd`
	echo $result
else
	echo "...Creating a new certificate..."
	cmd="sudo certbot certonly --manual --manual-auth-hook ./certbot-hook-auth.sh --manual-cleanup-hook ./certbot-hook-cleanup.sh -d $CERTBOT_DOMAIN --manual-public-ip-logging-ok --agree-tos --keep-until-expiring"
	echo $cmd
	result=`$cmd`
	echo $result
fi
