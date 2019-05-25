#!/bin/sh

echo
echo "============================================"
echo "Install extensions from   : install.sh"
echo "PHP version               : ${PHP_VERSION}"
echo "Extra Extensions          : ${PHP_EXTENSIONS}"
echo "Multicore Compilation     : ${MC}"
echo "Work directory            : ${PWD}"
echo "============================================"
echo


if [ "${ALPINE_REPOSITORIES}" != "" ]; then
    sed -i "s/dl-cdn.alpinelinux.org/${ALPINE_REPOSITORIES}/g" /etc/apk/repositories
fi


if [ "${PHP_EXTENSIONS}" != "" ]; then
    echo "---------- Install general dependencies ----------"
    apk add --no-cache autoconf g++ libtool make
fi

if [ -z "${EXTENSIONS##*,pdo_mysql,*}" ]; then
    echo "---------- Install pdo_mysql ----------"
    docker-php-ext-install -j$(nproc) pdo_mysql
fi

if [ -z "${EXTENSIONS##*,zip,*}" ]; then
	docker-php-ext-install -j$(nproc) zip
fi

if [ -z "${EXTENSIONS##*,pcntl,*}" ]; then
	docker-php-ext-install -j$(nproc) pcntl
fi

if [ -z "${EXTENSIONS##*,mysqli,*}" ]; then
	docker-php-ext-install -j$(nproc) mysqli
fi

if [ -z "${EXTENSIONS##*,mbstring,*}" ]; then
	docker-php-ext-install -j$(nproc) mbstring
fi

if [ -z "${EXTENSIONS##*,exif,*}" ]; then
	docker-php-ext-install -j$(nproc) exif
fi

if [ -z "${EXTENSIONS##*,bcmath,*}" ]; then
	docker-php-ext-install -j$(nproc) bcmath
fi

if [ -z "${EXTENSIONS##*,calendar,*}" ]; then
	docker-php-ext-install -j$(nproc) calendar
fi

if [ -z "${EXTENSIONS##*,sockets,*}" ]; then
	docker-php-ext-install -j$(nproc) sockets
fi

if [ -z "${EXTENSIONS##*,gettext,*}" ]; then
	docker-php-ext-install -j$(nproc) gettext
fi

if [ -z "${EXTENSIONS##*,shmop,*}" ]; then
	docker-php-ext-install -j$(nproc) shmop
fi

if [ -z "${EXTENSIONS##*,sysvmsg,*}" ]; then
	docker-php-ext-install -j$(nproc) sysvmsg
fi

if [ -z "${EXTENSIONS##*,sysvsem,*}" ]; then
	docker-php-ext-install -j$(nproc) sysvsem
fi

if [ -z "${EXTENSIONS##*,sysvshm,*}" ]; then
	docker-php-ext-install -j$(nproc) sysvshm
fi

if [ -z "${EXTENSIONS##*,pdo_firebird,*}" ]; then
	docker-php-ext-install -j$(nproc) pdo_firebird
fi

if [ -z "${EXTENSIONS##*,pdo_dblib,*}" ]; then
	docker-php-ext-install -j$(nproc) pdo_dblib
fi

if [ -z "${EXTENSIONS##*,pdo_oci,*}" ]; then
	docker-php-ext-install -j$(nproc) pdo_oci
fi

if [ -z "${EXTENSIONS##*,pdo_odbc,*}" ]; then
	docker-php-ext-install -j$(nproc) pdo_odbc
fi

if [ -z "${EXTENSIONS##*,pdo_pgsql,*}" ]; then
	docker-php-ext-install -j$(nproc) pdo_pgsql
fi

if [ -z "${EXTENSIONS##*,pgsql,*}" ]; then
	docker-php-ext-install -j$(nproc) pgsql
fi

if [ -z "${EXTENSIONS##*,oci8,*}" ]; then
	docker-php-ext-install -j$(nproc) oci8
fi

if [ -z "${EXTENSIONS##*,odbc,*}" ]; then
	docker-php-ext-install -j$(nproc) odbc
fi

if [ -z "${EXTENSIONS##*,dba,*}" ]; then
	docker-php-ext-install -j$(nproc) dba
fi

if [ -z "${EXTENSIONS##*,interbase,*}" ]; then
    echo "Alpine linux do not support interbase/firebird!!!"
	#docker-php-ext-install -j$(nproc) interbase
fi

if [ -z "${EXTENSIONS##*,gd,*}" ]; then
    apk add --no-cache freetype-dev libjpeg-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
fi

if [ -z "${EXTENSIONS##*,intl,*}" ]; then
    apk add --no-cache icu-dev
    docker-php-ext-install -j$(nproc) intl
fi

if [ -z "${EXTENSIONS##*,bz2,*}" ]; then
    apk add --no-cache bzip2-dev
    docker-php-ext-install -j$(nproc) bz2
fi

if [ -z "${EXTENSIONS##*,soap,*}" ]; then
	apk add --no-cache libxml2-dev
	docker-php-ext-install -j$(nproc) soap
fi

if [ -z "${EXTENSIONS##*,xsl,*}" ]; then
	apk add --no-cache libxml2-dev
	apk add --no-cache libxslt-dev
	docker-php-ext-install -j$(nproc) xsl
fi

if [ -z "${EXTENSIONS##*,xmlrpc,*}" ]; then
	apk add --no-cache libxml2-dev
	apk add --no-cache libxslt-dev
	docker-php-ext-install -j$(nproc) xmlrpc
fi

if [ -z "${EXTENSIONS##*,wddx,*}" ]; then
	apk add --no-cache libxml2-dev
	apk add --no-cache libxslt-dev
	docker-php-ext-install -j$(nproc) wddx
fi

if [ -z "${EXTENSIONS##*,curl,*}" ]; then
	apk add --no-cache curl
	apk add --no-cache curl-dev
	docker-php-ext-install -j$(nproc) curl
fi

if [ -z "${EXTENSIONS##*,readline,*}" ]; then
	apk add --no-cache readline-dev
	apk add --no-cache libedit-dev
	docker-php-ext-install -j$(nproc) readline
fi

if [ -z "${EXTENSIONS##*,snmp,*}" ]; then
	apk add --no-cache net-snmp-dev
	docker-php-ext-install -j$(nproc) snmp
fi

if [ -z "${EXTENSIONS##*,pspell,*}" ]; then
	apk add --no-cache aspell-dev
	apk add --no-cache aspell-en
	docker-php-ext-install -j$(nproc) pspell
fi

if [ -z "${EXTENSIONS##*,recode,*}" ]; then
	apk add --no-cache recode-dev
	docker-php-ext-install -j$(nproc) recode
fi

if [ -z "${EXTENSIONS##*,tidy,*}" ]; then
	apk add --no-cache tidyhtml-dev=5.2.0-r1 --repository http://${ALPINE_REPOSITORIES}/alpine/v3.6/community
	docker-php-ext-install -j$(nproc) tidy
fi

if [ -z "${EXTENSIONS##*,gmp,*}" ]; then
	apk add --no-cache gmp-dev
	docker-php-ext-install -j$(nproc) gmp
fi

if [ -z "${EXTENSIONS##*,imap,*}" ]; then
	apk add --no-cache imap-dev
    docker-php-ext-configure imap --with-imap --with-imap-ssl
	docker-php-ext-install -j$(nproc) imap
fi

if [ -z "${EXTENSIONS##*,ldap,*}" ]; then
	apk add --no-cache ldb-dev
	apk add --no-cache openldap-dev
	docker-php-ext-install -j$(nproc) ldap
fi

if [ -z "${EXTENSIONS##*,imagick,*}" ]; then
	apk add --no-cache file-dev
	apk add --no-cache imagemagick-dev
    printf "\n" | pecl install imagick-3.4.4
    docker-php-ext-enable imagick
fi

if [ -z "${EXTENSIONS##*,sqlsrv,*}" ]; then
	apk add --no-cache unixodbc-dev
    printf "\n" | pecl install sqlsrv
    docker-php-ext-enable sqlsrv
fi
