### Request a new certificate
`sudo certbot certonly --manual --manual-auth-hook ./certbot-hook-auth.sh --manual-cleanup-hook ./certbot-hook-cleanup.sh -d $CERTBOT_DOMAIN --manual-public-ip-logging-ok --agree-tos`

### Renew a certificate
`sudo certbot certonly --manual --manual-auth-hook ./certbot-hook-auth.sh --manual-cleanup-hook ./certbot-hook-cleanup.sh -d $CERTBOT_DOMAIN --manual-public-ip-logging-ok --agree-tos #--keep-until-expiring #--force-renewal`

*note: pass cli options to prevent interactivity*
