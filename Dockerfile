ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm

ARG SOURCE_LIST
ARG XDEBUG_VERSION
ARG SWOOLE_VERSION
ARG REDIS_VERSION=4.1.1
ARG SUPPORT_MCRYPT
ARG BUILT_IN_OPCACHE

COPY ./sources.list/$SOURCE_LIST /etc/apt/sources.list.tmp
RUN cc=$(curl 'https://ifconfig.co/country'); if [ "$cc" = "China" ]; then mv /etc/apt/sources.list.tmp /etc/apt/sources.list; fi
RUN apt-get update

# Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /bin/composer \
    && cc=$(curl 'https://ifconfig.co/country'); if [ "$cc" = "China" ]; then composer config -g repo.packagist composer https://packagist.phpcomposer.com; fi

# Install extensions from source
COPY ./extensions /tmp/extensions
RUN chmod +x /tmp/extensions/install.sh \
    && /tmp/extensions/install.sh \
    && rm -rf /tmp/extensions

# More extensions
# 1. soap requires libxml2-dev.
# 2. xml, xmlrpc, wddx require libxml2-dev and libxslt-dev.
# 3. Line `&& :\` do nothing just for better reading.
RUN if echo "$PHP_VERSION" | egrep -vq "5.4"; then echo "PHP_VERSION is $PHP_VERSION"; mt="-j$(nproc)"; fi; apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install $mt gd \
    && :\
    && apt-get install -y libicu-dev \
    && docker-php-ext-install $mt intl \
    && :\
    && apt-get install -y libxml2-dev \
    && apt-get install -y libxslt-dev \
    && docker-php-ext-install $mt soap \
    && docker-php-ext-install $mt xsl \
    && docker-php-ext-install $mt xmlrpc \
    && docker-php-ext-install $mt wddx \
    && :\
    && apt-get install -y libbz2-dev \
    && docker-php-ext-install $mt bz2 \
    && :\
    && docker-php-ext-install $mt zip \
    && docker-php-ext-install $mt pcntl \
    && docker-php-ext-install $mt pdo_mysql \
    && docker-php-ext-install $mt mysqli \
    && docker-php-ext-install $mt mbstring \
    && docker-php-ext-install $mt exif \
    && docker-php-ext-install $mt bcmath \
    && docker-php-ext-install $mt calendar \
    && docker-php-ext-install $mt sockets \
    && docker-php-ext-install $mt gettext \
    && docker-php-ext-install $mt shmop \
    && docker-php-ext-install $mt sysvmsg \
    && docker-php-ext-install $mt sysvsem \
    && docker-php-ext-install $mt sysvshm
    #&& docker-php-ext-install $mt opcache
    #&& docker-php-ext-install $mt pdo_firebird \
    #&& docker-php-ext-install $mt pdo_dblib \
    #&& docker-php-ext-install $mt pdo_oci \
    #&& docker-php-ext-install $mt pdo_odbc \
    #&& docker-php-ext-install $mt pdo_pgsql \
    #&& docker-php-ext-install $mt pgsql \
    #&& docker-php-ext-install $mt oci8 \
    #&& docker-php-ext-install $mt odbc \
    #&& docker-php-ext-install $mt dba \
    #&& docker-php-ext-install $mt interbase \
    #&& :\
    #&& apt-get install -y curl \
    #&& apt-get install -y libcurl3 \
    #&& apt-get install -y libcurl4-openssl-dev \
    #&& docker-php-ext-install $mt curl \
    #&& :\
    #&& apt-get install -y libreadline-dev \
    #&& docker-php-ext-install $mt readline \
    #&& :\
    #&& apt-get install -y libsnmp-dev \
    #&& apt-get install -y snmp \
    #&& docker-php-ext-install $mt snmp \
    #&& :\
    #&& apt-get install -y libpspell-dev \
    #&& apt-get install -y aspell-en \
    #&& docker-php-ext-install $mt pspell \
    #&& :\
    #&& apt-get install -y librecode0 \
    #&& apt-get install -y librecode-dev \
    #&& docker-php-ext-install $mt recode \
    #&& :\
    #&& apt-get install -y libtidy-dev \
    #&& docker-php-ext-install $mt tidy \
    #&& :\
    #&& apt-get install -y libgmp-dev \
    #&& ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
    #&& docker-php-ext-install $mt gmp \
    #&& :\
    #&& apt-get install -y postgresql-client \
    #&& apt-get install -y mysql-client \
    #&& :\
    #&& apt-get install -y libc-client-dev \
    #&& docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    #&& docker-php-ext-install $mt imap \
    #&& :\
    #&& apt-get install -y libldb-dev \
    #&& apt-get install -y libldap2-dev \
    #&& docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
    #&& docker-php-ext-install $mt ldap \
    #&& :\
    #&& apt-get install -y libmagickwand-dev \
    #&& pecl install imagick-3.4.3 \
    #&& docker-php-ext-enable imagick \
    #&& :\
    #&& apt-get install -y libmemcached-dev zlib1g-dev \
    #&& pecl install memcached-2.2.0 \
    #&& docker-php-ext-enable memcached
