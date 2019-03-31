#!/bin/bash

export CERTBOT_DOMAIN=$1

sudo certbot certonly --manual --manual-auth-hook ./certbot-hook-auth.sh --manual-cleanup-hook ./certbot-hook-cleanup.sh -d $CERTBOT_DOMAIN --manual-public-ip-logging-ok --agree-tos --keep-until-expiring #--force-renewal
