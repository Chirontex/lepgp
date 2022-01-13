FROM ubuntu:latest

RUN apt-get dist-upgrade \
    && apt-get update \
    && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8
ENV LANG ru_RU.utf8

RUN apt-get update
RUN apt-get install -y sudo \
    net-tools\
    htop \
    curl \
    wget \
    git

RUN echo "Europe/Moscow" > /etc/timezone
RUN mkdir /tmp/tmzns && cd /tmp/tmzns
RUN wget ftp://ftp.iana.org/tz/tzdata-latest.tar.gz
RUN tar zxvf tzdata-latest.tar.gz
RUN zic africa antarctica asia australasia europe northamerica southamerica
RUN ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
RUN rm -rf /tmp/tmzns
RUN apt-get install -y mc \
    nginx

RUN apt-get install -y postgresql

RUN apt-get install -y software-properties-common && add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y php7.4 php7.4-fpm php7.4-cli \
    php8.0 php8.0-fpm php8.0-cli \
    php8.1 php8.1-fpm php8.1-cli

RUN apt-get update

RUN apt-get install -y php-xdebug-all-dev
RUN apt-get install -y php-pear
RUN apt-get install -y php-mbstring
RUN apt-get install -y php-bcmath
RUN apt-get install -y php-bz2
RUN apt-get install -y php-curl
RUN apt-get install -y php-date
RUN apt-get install -y php-db
RUN apt-get install -y php-dev

RUN apt-get install -y php-grpc
RUN apt-get install -y php-imagick
RUN apt-get install -y php-intl
RUN apt-get install -y php-ldap
RUN apt-get install -y php-mcrypt
RUN apt-get install -y php-memcache
RUN apt-get install -y php-memcached
RUN apt-get install -y php-mf2
RUN apt-get install -y php-zip
RUN apt-get install -y php-json

RUN apt-get install -y php-mongo
RUN apt-get install -y php-mcrypt
RUN apt-get install -y php-mongodb
RUN apt-get install -y php-odbc
RUN apt-get install -y php-pclzip
RUN apt-get install -y php-pgsql
RUN apt-get install -y php7.4-pgsql
RUN apt-get install -y php8.0-pgsql
RUN apt-get install -y php8.1-pgsql

RUN apt-get install -y php-sodium
RUN apt-get install -y php-redis
RUN apt-get install -y php-soap
RUN apt-get install -y php-mysql
RUN apt-get install -y php-sqlite3
RUN apt-get install -y php-ssh2
RUN apt-get install -y php-tcpdf
RUN apt-get install -y php-tidy
RUN apt-get install -y php-tokenizer
RUN apt-get install -y php-yaml
RUN apt-get install -y php-xml
RUN apt-get install -y php-uploadprogress

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get install -y nodejs \
    yarnpkg

RUN echo "short_open_tag = On\n\
max_execution_time = 60\n\
memory_limit = 256M\n\
display_errors = On\n\
display_startup_errors = On\n\
ignore_repeated_errors = On\n\
post_max_size = 32M\n\
upload_max_filesize = 32M\n\
xdebug.mode = debug\n\
xdebug.client_host = host.docker.internal\n\
" > /etc/php/custom-config.ini

RUN ln -sf /etc/php/custom-config.ini /etc/php/7.4/mods-available/custom-config.ini
RUN ln -sf /etc/php/7.4/mods-available/custom-config.ini /etc/php/7.4/fpm/conf.d/100-custom-config.ini
RUN ln -sf /etc/php/7.4/mods-available/custom-config.ini /etc/php/7.4/cli/conf.d/100-custom-config.ini

RUN ln -sf /etc/php/custom-config.ini /etc/php/8.0/mods-available/custom-config.ini
RUN ln -sf /etc/php/8.0/mods-available/custom-config.ini /etc/php/8.0/fpm/conf.d/100-custom-config.ini
RUN ln -sf /etc/php/8.0/mods-available/custom-config.ini /etc/php/8.0/cli/conf.d/100-custom-config.ini

RUN ln -sf /etc/php/custom-config.ini /etc/php/8.1/mods-available/custom-config.ini
RUN ln -sf /etc/php/8.1/mods-available/custom-config.ini /etc/php/8.1/fpm/conf.d/100-custom-config.ini
RUN ln -sf /etc/php/8.1/mods-available/custom-config.ini /etc/php/8.1/cli/conf.d/100-custom-config.ini

ENTRYPOINT service nginx start \
    && service postgresql start \
    && tail -F /var/log/nginx/error.log

EXPOSE 80
EXPOSE 5432
EXPOSE 9003
