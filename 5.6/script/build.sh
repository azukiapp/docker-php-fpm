#!/usr/bin/env sh

cd $(dirname $0)

echo "PWD: $(pwd)"

# Install apk packages and remove apk cache when finished.

apk --update add \
    nginx \
    php-fpm \
    supervisor

rm -rf /var/cache/apk/*

rm -rf /var/www/*

# Update php configuration.

sed -i \
    -e 's/group =.*/group = nginx/' \
    -e 's/user =.*/user = nginx/' \
    -e 's/listen\.owner.*/listen\.owner = nginx/' \
    -e 's/listen\.group.*/listen\.group = nginx/' \
    -e 's/error_log =.*/error_log = \/dev\/stdout/' \
    -e 's/;clear_env = no/clear_env = no/g' \
    /etc/php/php-fpm.conf

sed -i \
    -e '/open_basedir =/s/^/\;/' \
    /etc/php/php.ini
