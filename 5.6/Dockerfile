# The container includes:
#
# - Git
# - Nginx
# - PHP Version 5.6.3 (With FPM)
# - Composer
# - Node
# - MySQL Client
# - PostgreSQL Client
# - MongoDB
# - SQLite3
#

FROM azukiapp/node
MAINTAINER Azuki <support@azukiapp.com>

# Add PHP repository to apt source
RUN echo "deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu trusty main" \
        > /etc/apt/sources.list.d/php5-5.6.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-key E5267A6C

# Install php5 + nginx + DB clients
RUN apt-get update \
  && apt-get install -y -qq \
      nginx \
      unzip \
      subversion \
      libxml2 \
      libcurl4-openssl-dev \
      php5-dev \
      php5-cli \
      php5-sqlite \
      php5-mysql \
      php5-pgsql \
      php5-mcrypt \
      php5-curl \
      php5-json \
      php5-gd \
      php5-fpm \
      php-pear \
      php-apc \
      sqlite3 libsqlite3-dev \
  && pecl install mongo \
  && apt-get clean -qq \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Enable php modules
RUN echo "extension=mongo.so" > /etc/php5/mods-available/mongo.ini
RUN php5enmod mcrypt mongo

# nginx config
ADD nginx-default.conf /etc/nginx/sites-available/default
RUN  echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini \
  && echo "daemon off;" >> /etc/nginx/nginx.conf

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add image configuration and scripts
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# Configure /app folder with sample app
RUN mkdir -p /app && rm -fr /var/www && ln -s /app /var/www
ADD sample/ /app/public

EXPOSE 80
CMD ["/run.sh"]
