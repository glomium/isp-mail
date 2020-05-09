#!/bin/sh
set -e

ls -ltrha /run/
ls -ltrha /run/secrets/

export ROUNDCUBE_DES_KEY=`cat /run/secrets/roundcube_des_key`
export ROUNDCUBE_DB_USERNAME=`cat /run/secrets/roundcube_db_username`
export ROUNDCUBE_DB_PASSWORD=`cat /run/secrets/roundcube_db_password`
export ROUNDCUBE_SMTP_USERNAME=`cat /run/secrets/roundcube_smtp_username`
export ROUNDCUBE_SMTP_PASSWORD=`cat /run/secrets/roundcube_smtp_password`

sed -i s/{{DES_KEY}}/$ROUNDCUBE_DES_KEY/ /var/www/html/config/config.inc.php
sed -i s/{{DB_PASSWORD}}/$ROUNDCUBE_DB_PASSWORD/ /var/www/html/config/config.inc.php
sed -i s/{{DB_USERNAME}}/$ROUNDCUBE_DB_USERNAME/ /var/www/html/config/config.inc.php
sed -i s/{{SMTP_PASSWORD}}/$ROUNDCUBE_SMTP_PASSWORD/ /var/www/html/config/config.inc.php
sed -i s/{{SMTP_USERNAME}}/$ROUNDCUBE_SMTP_USERNAME/ /var/www/html/config/config.inc.php

export ROUNDCUBE_DB_HOST=${1:-tasks.postgres}
export ROUNDCUBE_DB_NAME=${1:-roundcube}
export ROUNDCUBE_SMTP_SERVER=${1:-tasks.smtp}
export ROUNDCUBE_SMTP_PORT=${1:-25}
export ROUNDCUBE_PRODUCT_NAME=${1:-Webmail}

sed -i s/{{DB_HOST}}/$ROUNDCUBE_DB_HOST/ /var/www/html/config/config.inc.php
sed -i s/{{DB_NAME}}/$ROUNDCUBE_DB_NAME/ /var/www/html/config/config.inc.php
sed -i s/{{SMTP_SERVER}}/$ROUNDCUBE_SMTP_SERVER/ /var/www/html/config/config.inc.php
sed -i s/{{SMTP_PORT}}/$ROUNDCUBE_SMTP_PORT/ /var/www/html/config/config.inc.php
sed -i s/{{PRODUCT_NAME}}/$ROUNDCUBE_PRODUCT_NAME/ /var/www/html/config/config.inc.php

# ROUNDCUBE_DEFAULT_HOST=${1:-asd}
# ROUNDCUBE_SKIN_LOGO=${1:-asd}
# ROUNDCUBE_SUPPORT_URL=${1:-asd}

sed -i s/{{DEFAULT_HOST}}/$ROUNDCUBE_DEFAULT_HOST/ /var/www/html/config/config.inc.php
sed -i s/{{SKIN_LOGO}}/$ROUNDCUBE_SKIN_LOGO/ /var/www/html/config/config.inc.php
sed -i s/{{SUPPORT_URL}}/$ROUNDCUBE_SUPPORT_URL/ /var/www/html/config/config.inc.php

exec apache2 -DFOREGROUND $@
