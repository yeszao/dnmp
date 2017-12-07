FROM php:7.1.10-fpm
COPY ./sources.list.jessie /etc/apt/sources.list
RUN apt-get update

# mcrypt
RUN apt-get install -y libmcrypt-dev
RUN docker-php-ext-install mcrypt

# GD
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

# Intl
RUN apt-get install -y libicu-dev
RUN docker-php-ext-install intl

# General
RUN docker-php-ext-install zip
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install opcache
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install mbstring

# SOAP Client
RUN apt-get install -y libxml2-dev
RUN docker-php-ext-install soap

# The following extensions are bundled and compiled into PHP by default.
# ctype, dom, fileinfo, ftp, hash, iconv, json, pdo, pdo_sqlite, session,
# tokenizer, simplexml, xml, xmlreader, xmlwriter, phar
# If not, install them with `RUN docker-php-ext-install extension_name`

# CURL, may had be installed default
#RUN apt-get install -y curl
#RUN apt-get install -y libcurl3
#RUN apt-get install -y libcurl4-openssl-dev
#RUN docker-php-ext-install curl

# bz2
RUN apt-get install -y libbz2-dev
RUN docker-php-ext-install bz2

# More extensions
RUN docker-php-ext-install exif
#RUN docker-php-ext-install bcmath
RUN docker-php-ext-install calendar
RUN docker-php-ext-install sockets
RUN docker-php-ext-install gettext
RUN docker-php-ext-install shmop
RUN docker-php-ext-install sysvmsg
RUN docker-php-ext-install sysvsem
RUN docker-php-ext-install sysvshm

# More extensions handle database
#RUN docker-php-ext-install pdo_firebird
#RUN docker-php-ext-install pdo_dblib
#RUN docker-php-ext-install pdo_oci
#RUN docker-php-ext-install pdo_odbc
#RUN docker-php-ext-install pdo_pgsql
#RUN docker-php-ext-install pgsql
#RUN docker-php-ext-install oci8
#RUN docker-php-ext-install odbc
#RUN docker-php-ext-install dba
#RUN docker-php-ext-install interbase

# execute `RUN apt-get install -y libxml2-dev` before using following command
# RUN apt-get install -y libxml2-dev
RUN apt-get install -y libxslt-dev
RUN docker-php-ext-install xsl
RUN docker-php-ext-install xmlrpc
RUN docker-php-ext-install wddx

# Readline
#RUN apt-get install -y libreadline-dev
#RUN docker-php-ext-install readline

# SNMP
#RUN apt-get install -y libsnmp-dev
#RUN apt-get install -y snmp
#RUN docker-php-ext-install snmp

# pspell
#RUN apt-get install -y libpspell-dev
#RUN apt-get install -y aspell-en
#RUN docker-php-ext-install pspell

# recode
#RUN apt-get install -y librecode0
#RUN apt-get install -y librecode-dev
#RUN docker-php-ext-install recode

# Tidy
RUN apt-get install -y libtidy-dev
RUN docker-php-ext-install tidy

# GMP
RUN apt-get install -y libgmp-dev
# Fixing "configure: error: Unable to locate gmp.h"
RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h
RUN docker-php-ext-install gmp

# Client
#RUN apt-get install -y postgresql-client
#RUN apt-get install -y mysql-client

# IMAP
#RUN apt-get install -y libc-client-dev
#RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
#RUN docker-php-ext-install imap

# LDAP
#RUN apt-get install -y libldb-dev
#RUN apt-get install -y libldap2-dev
#RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu
#RUN docker-php-ext-install ldap

# Composer
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# pecl extensions
# Notice: if get error 
#    `No releases available for package "pecl.php.net/xxx"`
# or
#    `Package "xxx" does not have REST xml available`
# Please turn on you proxy (the proxy IP may be docker host IP or others).
#RUN export http_proxy=10.0.75.1:1080
#RUN export https_proxy=10.0.75.1:1080

RUN pecl install redis && docker-php-ext-enable redis
#pecl install xdebug requires PHP >= 5.5.0
RUN pecl install xdebug && docker-php-ext-enable xdebug
RUN pecl install igbinary && docker-php-ext-enable igbinary
RUN apt-get install -y libmagickwand-dev && pecl install imagick && docker-php-ext-enable imagick
#pecl install memcached requires PHP (version >= 7.0.0)
RUN apt-get install -y libmemcached-dev zlib1g-dev && pecl install memcached && docker-php-ext-enable memcached

# Install Yaf from source
COPY ./yaf-2.3.2-x.tgz /tmp/
RUN cd /tmp/ \
        && tar -xf yaf-3.0.5-x.tar.gz \
		&& rm yaf-3.0.5-x.tar.gz \
        && ( cd yaf-3.0.5-x && phpize && ./configure && make && make install ) \
        && rm -r yaf-3.0.5-x
RUN docker-php-ext-enable yaf
