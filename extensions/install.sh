#!/bin/bash

echo
echo "============================================"
echo "PHP version       : ${PHP_VERSION}"
echo "Extra Extensions  : ${PHP_EXTENSIONS}"
echo "============================================"
echo


EXTENSIONS=(${PHP_EXTENSIONS//,/ })
export EXTENSIONS
echo "export ${EXTENSIONS[*]}"


if [ "${REPLACE_SOURCE_LIST}" = "true" ]; then
    cp /tmp/sources.list /etc/apt/sources.list;
fi


if [ ! "${PHP_EXTENSIONS}" = "" ]; then
    echo "↓---------- Update source list ----------↓"
    apt-get update
fi


cd /tmp/extensions
if [ -f "${MORE_EXTENSION_INSTALLER}" ]; then
    . ./${MORE_EXTENSION_INSTALLER}
fi


if [[ " ${EXTENSIONS[@]} " =~ " gd " ]]; then
    apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install $mc gd
fi

if [[ " ${EXTENSIONS[@]} " =~ " pdo_mysql " ]]; then
    echo "↓---------- Install pdo_mysql ----------↓"
    docker-php-ext-install $mc pdo_mysql
fi

if [[ " ${EXTENSIONS[@]} " =~ " intl " ]]; then
    apt-get install -y libicu-dev
    docker-php-ext-install $mc intl
fi

if [[ " ${EXTENSIONS[@]} " =~ " bz2 " ]]; then
    apt-get install -y libbz2-dev
    docker-php-ext-install $mc bz2
fi

if [[ " ${EXTENSIONS[@]} " =~ " zip " ]]; then
	docker-php-ext-install $mc zip
fi

if [[ " ${EXTENSIONS[@]} " =~ " pcntl " ]]; then
	docker-php-ext-install $mc pcntl
fi

if [[ " ${EXTENSIONS[@]} " =~ " mysqli " ]]; then
	docker-php-ext-install $mc mysqli
fi

if [[ " ${EXTENSIONS[@]} " =~ " mbstring " ]]; then
	docker-php-ext-install $mc mbstring
fi

if [[ " ${EXTENSIONS[@]} " =~ " exif " ]]; then
	docker-php-ext-install $mc exif
fi

if [[ " ${EXTENSIONS[@]} " =~ " bcmath " ]]; then
	docker-php-ext-install $mc bcmath
fi

if [[ " ${EXTENSIONS[@]} " =~ " calendar " ]]; then
	docker-php-ext-install $mc calendar
fi

if [[ " ${EXTENSIONS[@]} " =~ " sockets " ]]; then
	docker-php-ext-install $mc sockets
fi

if [[ " ${EXTENSIONS[@]} " =~ " gettext " ]]; then
	docker-php-ext-install $mc gettext
fi

if [[ " ${EXTENSIONS[@]} " =~ " shmop " ]]; then
	docker-php-ext-install $mc shmop
fi

if [[ " ${EXTENSIONS[@]} " =~ " sysvmsg " ]]; then
	docker-php-ext-install $mc sysvmsg
fi

if [[ " ${EXTENSIONS[@]} " =~ " sysvsem " ]]; then
	docker-php-ext-install $mc sysvsem
fi

if [[ " ${EXTENSIONS[@]} " =~ " sysvshm " ]]; then
	docker-php-ext-install $mc sysvshm
fi

if [[ " ${EXTENSIONS[@]} " =~ " pdo_firebird " ]]; then
	docker-php-ext-install $mc pdo_firebird
fi

if [[ " ${EXTENSIONS[@]} " =~ " pdo_dblib " ]]; then
	docker-php-ext-install $mc pdo_dblib
fi

if [[ " ${EXTENSIONS[@]} " =~ " pdo_oci " ]]; then
	docker-php-ext-install $mc pdo_oci
fi

if [[ " ${EXTENSIONS[@]} " =~ " pdo_odbc " ]]; then
	docker-php-ext-install $mc pdo_odbc
fi

if [[ " ${EXTENSIONS[@]} " =~ " pdo_pgsql " ]]; then
	docker-php-ext-install $mc pdo_pgsql
fi

if [[ " ${EXTENSIONS[@]} " =~ " pgsql " ]]; then
	docker-php-ext-install $mc pgsql
fi

if [[ " ${EXTENSIONS[@]} " =~ " oci8 " ]]; then
	docker-php-ext-install $mc oci8
fi

if [[ " ${EXTENSIONS[@]} " =~ " odbc " ]]; then
	docker-php-ext-install $mc odbc
fi

if [[ " ${EXTENSIONS[@]} " =~ " dba " ]]; then
	docker-php-ext-install $mc dba
fi

if [[ " ${EXTENSIONS[@]} " =~ " interbase " ]]; then
	docker-php-ext-install $mc interbase
fi

if [[ " ${EXTENSIONS[@]} " =~ " soap " ]]; then
	apt-get install -y libxml2-dev
	docker-php-ext-install $mc soap
fi


if [[ " ${EXTENSIONS[@]} " =~ " xsl " ]]; then
	apt-get install -y libxml2-dev
	apt-get install -y libxslt-dev
	docker-php-ext-install $mc xsl
fi

if [[ " ${EXTENSIONS[@]} " =~ " xmlrpc " ]]; then
	apt-get install -y libxml2-dev
	apt-get install -y libxslt-dev
	docker-php-ext-install $mc xmlrpc
fi

if [[ " ${EXTENSIONS[@]} " =~ " wddx " ]]; then
	apt-get install -y libxml2-dev
	apt-get install -y libxslt-dev
	docker-php-ext-install $mc wddx
fi

if [[ " ${EXTENSIONS[@]} " =~ " curl " ]]; then
	apt-get install -y curl
	apt-get install -y libcurl3
	apt-get install -y libcurl4-openssl-dev
	docker-php-ext-install $mc curl
fi

if [[ " ${EXTENSIONS[@]} " =~ " readline " ]]; then
	apt-get install -y libreadline-dev
	docker-php-ext-install $mc readline
fi

if [[ " ${EXTENSIONS[@]} " =~ " snmp " ]]; then
	apt-get install -y libsnmp-dev
	apt-get install -y snmp
	docker-php-ext-install $mc snmp
fi

if [[ " ${EXTENSIONS[@]} " =~ " pspell " ]]; then
	apt-get install -y libpspell-dev
	apt-get install -y aspell-en
	docker-php-ext-install $mc pspell
fi

if [[ " ${EXTENSIONS[@]} " =~ " recode " ]]; then
	apt-get install -y librecode0
	apt-get install -y librecode-dev
	docker-php-ext-install $mc recode
fi

if [[ " ${EXTENSIONS[@]} " =~ " tidy " ]]; then
	apt-get install -y libtidy-dev
	docker-php-ext-install $mc tidy
fi

if [[ " ${EXTENSIONS[@]} " =~ " gmp " ]]; then
	apt-get install -y libgmp-dev
    ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h
	docker-php-ext-install $mc gmp
fi

if [[ " ${EXTENSIONS[@]} " =~ " postgresql-client " ]]; then
	apt-get install -y postgresql-client
fi

if [[ " ${EXTENSIONS[@]} " =~ " mysql-client " ]]; then
	apt-get install -y mysql-client
fi

if [[ " ${EXTENSIONS[@]} " =~ " imap " ]]; then
	apt-get install -y libc-client-dev
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl
	docker-php-ext-install $mc imap
fi

if [[ " ${EXTENSIONS[@]} " =~ " ldap " ]]; then
	apt-get install -y libldb-dev
	apt-get install -y libldap2-dev
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu
	docker-php-ext-install $mc ldap
fi

if [[ " ${EXTENSIONS[@]} " =~ " imagick " ]]; then
	apt-get install -y libmagickwand-dev
    pecl install imagick-3.4.3
    docker-php-ext-enable imagick
fi

if [[ " ${EXTENSIONS[@]} " =~ " memcached " ]]; then
	apt-get install -y libmemcached-dev zlib1g-dev
    pecl install memcached-2.2.0
    docker-php-ext-enable memcached
fi

if [[ " ${EXTENSIONS[@]} " =~ " sqlsrv " ]]; then
	apt-get install -y unixodbc-dev
    pecl install sqlsrv
    docker-php-ext-enable sqlsrv
fi

if [[ " ${EXTENSIONS[@]} " =~ " pdo_sqlsrv " ]]; then
	apt-get install -y unixodbc-dev
    pecl install pdo_sqlsrv
    docker-php-ext-enable pdo_sqlsrv
fi

rm -rf /tmp/sources.list
rm -rf /tmp/extensions