FROM azukiapp/alpine
MAINTAINER Azuki <support@azukiapp.com>

COPY . /docker
RUN /docker/script/build.sh
EXPOSE 80 443
VOLUME /docker/configuration

# nginx config
# ADD nginx-default.conf /etc/nginx/sites-available/default
# RUN  echo "daemon off;" >> /etc/nginx/nginx.conf \
#   && echo "fix ownership of sock file for php-fpm as our version of nginx runs as root" \
#   && sed -i -e "s/user www-data/user root/g" /etc/nginx/nginx.conf \
#   && sed -i -e "s/www-data/root/g" /etc/php5/fpm/pool.d/www.conf \
#   && sed -i -e "s/;clear_env = no/clear_env = no/g" /etc/php5/fpm/pool.d/www.conf \
#   && sed -i -e "s/DAEMON_ARGS=\"/DAEMON_ARGS=\"--allow-to-run-as-root /g" /etc/init.d/php5-fpm

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENTRYPOINT ["/docker/script/entrypoint.sh"]
CMD ["nginx-php-fpm"]
