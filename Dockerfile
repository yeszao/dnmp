ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm

ARG SOURCE_LIST
ARG XDEBUG_VERSION
ARG SWOOLE_VERSION
ARG REDIS_VERSION=4.1.1
ARG SUPPORT_MCRYPT
ARG BUILT_IN_OPCACHE

COPY ./sources.list/$SOURCE_LIST /etc/apt/sources.list
RUN apt-get update

# Composer
RUN php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /bin/composer \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com

# Install extensions from source
COPY ./extensions /tmp/extensions
RUN chmod +x /tmp/extensions/install.sh \
    && /tmp/extensions/install.sh \
    && rm -rf /tmp/extensions

# More extensions
# 1. soap requires libxml2-dev.
# 2. xml, xmlrpc, wddx require libxml2-dev and libxslt-dev.
# 3. Line `&& :\` do nothing just for better reading.
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && :\
    && apt-get install -y libicu-dev \
    && docker-php-ext-install intl \
    && :\
    && apt-get install -y libxml2-dev \
    && apt-get install -y libxslt-dev \
    && docker-php-ext-install soap \
    && docker-php-ext-install xsl \
    && docker-php-ext-install xmlrpc \
    && docker-php-ext-install wddx \
    && :\
    && apt-get install -y libbz2-dev \
    && docker-php-ext-install bz2 \
    && :\
    && docker-php-ext-install zip \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install exif \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install calendar \
    && docker-php-ext-install sockets \
    && docker-php-ext-install gettext \
    && docker-php-ext-install shmop \
    && docker-php-ext-install sysvmsg \
    && docker-php-ext-install sysvsem \
    && docker-php-ext-install sysvshm
    #&& docker-php-ext-install opcache
    #&& docker-php-ext-install pdo_firebird \
    #&& docker-php-ext-install pdo_dblib \
    #&& docker-php-ext-install pdo_oci \
    #&& docker-php-ext-install pdo_odbc \
    #&& docker-php-ext-install pdo_pgsql \
    #&& docker-php-ext-install pgsql \
    #&& docker-php-ext-install oci8 \
    #&& docker-php-ext-install odbc \
    #&& docker-php-ext-install dba \
    #&& docker-php-ext-install interbase \
    #&& :\
    #&& apt-get install -y curl \
    #&& apt-get install -y libcurl3 \
    #&& apt-get install -y libcurl4-openssl-dev \
    #&& docker-php-ext-install curl \
    #&& :\
    #&& apt-get install -y libreadline-dev \
    #&& docker-php-ext-install readline \
    #&& :\
    #&& apt-get install -y libsnmp-dev \
    #&& apt-get install -y snmp \
    #&& docker-php-ext-install snmp \
    #&& :\
    #&& apt-get install -y libpspell-dev \
    #&& apt-get install -y aspell-en \
    #&& docker-php-ext-install pspell \
    #&& :\
    #&& apt-get install -y librecode0 \
    #&& apt-get install -y librecode-dev \
    #&& docker-php-ext-install recode \
    #&& :\
    #&& apt-get install -y libtidy-dev \
    #&& docker-php-ext-install tidy \
    #&& :\
    #&& apt-get install -y libgmp-dev \
    #&& ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
    #&& docker-php-ext-install gmp \
    #&& :\
    #&& apt-get install -y postgresql-client \
    #&& apt-get install -y mysql-client \
    #&& :\
    #&& apt-get install -y libc-client-dev \
    #&& docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    #&& docker-php-ext-install imap \
    #&& :\
    #&& apt-get install -y libldb-dev \
    #&& apt-get install -y libldap2-dev \
    #&& docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
    #&& docker-php-ext-install ldap \
    #&& :\
    #&& apt-get install -y libmagickwand-dev \
    #&& pecl install imagick-3.4.3 \
    #&& docker-php-ext-enable imagick \
    #&& :\
    #&& apt-get install -y libmemcached-dev zlib1g-dev \
    #&& pecl install memcached-2.2.0 \
    #&& docker-php-ext-enable memcached
