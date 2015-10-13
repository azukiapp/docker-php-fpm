FROM azukiapp/alpine
MAINTAINER Azuki <support@azukiapp.com>

# Install apk packages and remove apk cache when finished.
RUN  apk --update add \
        nginx \
        php-fpm php-json php-zlib php-xml php-pdo php-phar php-openssl php-mcrypt \
        supervisor \
  && rm -rf /var/cache/apk/* /var/www/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . /docker
RUN /docker/script/prepare.sh

EXPOSE 80 443
VOLUME /docker/configuration

ENTRYPOINT ["/docker/script/entrypoint.sh"]
CMD ["nginx-php-fpm"]
