#!/bin/sh

export MC="-j$(nproc)"

echo
echo "============================================"
echo "Install extensions from   : install.sh"
echo "PHP version               : ${PHP_VERSION}"
echo "Extra Extensions          : ${PHP_EXTENSIONS}"
echo "Multicore Compilation     : ${MC}"
echo "Container package url     : ${CONTAINER_PACKAGE_URL}"
echo "Work directory            : ${PWD}"
echo "============================================"
echo


export EXTENSIONS=",${PHP_EXTENSIONS},"


isPhpVersionGreaterOrEqual()
 {
    local PHP_MAJOR_VERSION=$(php -r "echo PHP_MAJOR_VERSION;")
    local PHP_MINOR_VERSION=$(php -r "echo PHP_MINOR_VERSION;")

    if [[ "$PHP_MAJOR_VERSION" -gt "$1" || "$PHP_MAJOR_VERSION" -eq "$1" && "$PHP_MINOR_VERSION" -ge "$2" ]]; then
        return 1;
    else
        return 0;
    fi
}


if [[ -z "${EXTENSIONS##*,pdo_mysql,*}" ]]; then
    echo "---------- Install pdo_mysql ----------"
    docker-php-ext-install ${MC} pdo_mysql
fi

if [[ -z "${EXTENSIONS##*,pcntl,*}" ]]; then
    echo "---------- Install pcntl ----------"
	docker-php-ext-install ${MC} pcntl
fi

if [[ -z "${EXTENSIONS##*,mysqli,*}" ]]; then
    echo "---------- Install mysqli ----------"
	docker-php-ext-install ${MC} mysqli
fi

if [[ -z "${EXTENSIONS##*,mbstring,*}" ]]; then
    echo "---------- mbstring is installed ----------"
fi

if [[ -z "${EXTENSIONS##*,exif,*}" ]]; then
    echo "---------- Install exif ----------"
	docker-php-ext-install ${MC} exif
fi

if [[ -z "${EXTENSIONS##*,bcmath,*}" ]]; then
    echo "---------- Install bcmath ----------"
	docker-php-ext-install ${MC} bcmath
fi

if [[ -z "${EXTENSIONS##*,calendar,*}" ]]; then
    echo "---------- Install calendar ----------"
	docker-php-ext-install ${MC} calendar
fi

if [[ -z "${EXTENSIONS##*,zend_test,*}" ]]; then
    echo "---------- Install zend_test ----------"
	docker-php-ext-install ${MC} zend_test
fi

if [[ -z "${EXTENSIONS##*,opcache,*}" ]]; then
    echo "---------- Install opcache ----------"
    docker-php-ext-install opcache
fi

if [[ -z "${EXTENSIONS##*,sockets,*}" ]]; then
    echo "---------- Install sockets ----------"
	docker-php-ext-install ${MC} sockets
fi

if [[ -z "${EXTENSIONS##*,gettext,*}" ]]; then
    echo "---------- Install gettext ----------"
	docker-php-ext-install ${MC} gettext
fi

if [[ -z "${EXTENSIONS##*,shmop,*}" ]]; then
    echo "---------- Install shmop ----------"
	docker-php-ext-install ${MC} shmop
fi

if [[ -z "${EXTENSIONS##*,sysvmsg,*}" ]]; then
    echo "---------- Install sysvmsg ----------"
	docker-php-ext-install ${MC} sysvmsg
fi

if [[ -z "${EXTENSIONS##*,sysvsem,*}" ]]; then
    echo "---------- Install sysvsem ----------"
	docker-php-ext-install ${MC} sysvsem
fi

if [[ -z "${EXTENSIONS##*,sysvshm,*}" ]]; then
    echo "---------- Install sysvshm ----------"
	docker-php-ext-install ${MC} sysvshm
fi

if [[ -z "${EXTENSIONS##*,pdo_firebird,*}" ]]; then
    echo "---------- Install pdo_firebird ----------"
	docker-php-ext-install ${MC} pdo_firebird
fi

if [[ -z "${EXTENSIONS##*,pdo_dblib,*}" ]]; then
    echo "---------- Install pdo_dblib ----------"
	docker-php-ext-install ${MC} pdo_dblib
fi

if [[ -z "${EXTENSIONS##*,pdo_oci,*}" ]]; then
    echo "---------- Install pdo_oci ----------"
	docker-php-ext-install ${MC} pdo_oci
fi

if [[ -z "${EXTENSIONS##*,pdo_odbc,*}" ]]; then
    echo "---------- Install pdo_odbc ----------"
	docker-php-ext-install ${MC} pdo_odbc
fi

if [[ -z "${EXTENSIONS##*,pdo_pgsql,*}" ]]; then
    echo "---------- Install pdo_pgsql ----------"
    apk --no-cache add postgresql-dev \
    && docker-php-ext-install ${MC} pdo_pgsql
fi

if [[ -z "${EXTENSIONS##*,pgsql,*}" ]]; then
    echo "---------- Install pgsql ----------"
    apk --no-cache add postgresql-dev \
    && docker-php-ext-install ${MC} pgsql
fi

if [[ -z "${EXTENSIONS##*,oci8,*}" ]]; then
    echo "---------- Install oci8 ----------"
	docker-php-ext-install ${MC} oci8
fi

if [[ -z "${EXTENSIONS##*,odbc,*}" ]]; then
    echo "---------- Install odbc ----------"
	docker-php-ext-install ${MC} odbc
fi

if [[ -z "${EXTENSIONS##*,dba,*}" ]]; then
    echo "---------- Install dba ----------"
	docker-php-ext-install ${MC} dba
fi

if [[ -z "${EXTENSIONS##*,interbase,*}" ]]; then
    echo "---------- Install interbase ----------"
    echo "Alpine linux do not support interbase/firebird!!!"
	#docker-php-ext-install ${MC} interbase
fi

if [[ -z "${EXTENSIONS##*,gd,*}" ]]; then
    echo "---------- Install gd ----------"
    apk add --no-cache freetype-dev libjpeg-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install ${MC} gd
fi

if [[ -z "${EXTENSIONS##*,intl,*}" ]]; then
    echo "---------- Install intl ----------"
    apk add --no-cache icu-dev
    docker-php-ext-install ${MC} intl
fi

if [[ -z "${EXTENSIONS##*,bz2,*}" ]]; then
    echo "---------- Install bz2 ----------"
    apk add --no-cache bzip2-dev
    docker-php-ext-install ${MC} bz2
fi

if [[ -z "${EXTENSIONS##*,soap,*}" ]]; then
    echo "---------- Install soap ----------"
	docker-php-ext-install ${MC} soap
fi

if [[ -z "${EXTENSIONS##*,xsl,*}" ]]; then
    echo "---------- Install xsl ----------"
	apk add --no-cache libxslt-dev
	docker-php-ext-install ${MC} xsl
fi

if [[ -z "${EXTENSIONS##*,xmlrpc,*}" ]]; then
    echo "---------- Install xmlrpc ----------"
	apk add --no-cache libxslt-dev
	docker-php-ext-install ${MC} xmlrpc
fi

if [[ -z "${EXTENSIONS##*,wddx,*}" ]]; then
    echo "---------- Install wddx ----------"
	apk add --no-cache libxslt-dev
	docker-php-ext-install ${MC} wddx
fi

if [[ -z "${EXTENSIONS##*,curl,*}" ]]; then
    echo "---------- curl is installed ----------"
fi

if [[ -z "${EXTENSIONS##*,readline,*}" ]]; then
    echo "---------- Install readline ----------"
	apk add --no-cache readline-dev
	apk add --no-cache libedit-dev
	docker-php-ext-install ${MC} readline
fi

if [[ -z "${EXTENSIONS##*,snmp,*}" ]]; then
    echo "---------- Install snmp ----------"
	apk add --no-cache net-snmp-dev
	docker-php-ext-install ${MC} snmp
fi

if [[ -z "${EXTENSIONS##*,pspell,*}" ]]; then
    echo "---------- Install pspell ----------"
	apk add --no-cache aspell-dev
	apk add --no-cache aspell-en
	docker-php-ext-install ${MC} pspell
fi

if [[ -z "${EXTENSIONS##*,recode,*}" ]]; then
    echo "---------- Install recode ----------"
	apk add --no-cache recode-dev
	docker-php-ext-install ${MC} recode
fi

if [[ -z "${EXTENSIONS##*,tidy,*}" ]]; then
    echo "---------- Install tidy ----------"
	apk add --no-cache tidyhtml-dev

	# Fix: https://github.com/htacg/tidy-html5/issues/235
	ln -s /usr/include/tidybuffio.h /usr/include/buffio.h

	docker-php-ext-install ${MC} tidy
fi

if [[ -z "${EXTENSIONS##*,gmp,*}" ]]; then
    echo "---------- Install gmp ----------"
	apk add --no-cache gmp-dev
	docker-php-ext-install ${MC} gmp
fi

if [[ -z "${EXTENSIONS##*,imap,*}" ]]; then
    echo "---------- Install imap ----------"
	apk add --no-cache imap-dev
    docker-php-ext-configure imap --with-imap --with-imap-ssl
	docker-php-ext-install ${MC} imap
fi

if [[ -z "${EXTENSIONS##*,ldap,*}" ]]; then
    echo "---------- Install ldap ----------"
	apk add --no-cache ldb-dev
	apk add --no-cache openldap-dev
	docker-php-ext-install ${MC} ldap
fi

if [[ -z "${EXTENSIONS##*,imagick,*}" ]]; then
    echo "---------- Install imagick ----------"
	apk add --no-cache file-dev
	apk add --no-cache imagemagick-dev
    printf "\n" | pecl install imagick-3.4.4
    docker-php-ext-enable imagick
fi

if [[ -z "${EXTENSIONS##*,rar,*}" ]]; then
    echo "---------- Install rar ----------"
    printf "\n" | pecl install rar
    docker-php-ext-enable rar
fi

if [[ -z "${EXTENSIONS##*,ast,*}" ]]; then
    echo "---------- Install ast ----------"
    printf "\n" | pecl install ast
    docker-php-ext-enable ast
fi

if [[ -z "${EXTENSIONS##*,msgpack,*}" ]]; then
    echo "---------- Install msgpack ----------"
    printf "\n" | pecl install msgpack
    docker-php-ext-enable msgpack
fi

if [[ -z "${EXTENSIONS##*,igbinary,*}" ]]; then
    echo "---------- Install igbinary ----------"
    printf "\n" | pecl install igbinary
    docker-php-ext-enable igbinary
fi


if [[ -z "${EXTENSIONS##*,yac,*}" ]]; then
    echo "---------- Install yac ----------"
    printf "\n" | pecl install yac-2.0.2
    docker-php-ext-enable yac
fi

if [[ -z "${EXTENSIONS##*,yaconf,*}" ]]; then
    echo "---------- Install yaconf ----------"
    printf "\n" | pecl install yaconf
    docker-php-ext-enable yaconf
fi

if [[ -z "${EXTENSIONS##*,seaslog,*}" ]]; then
    echo "---------- Install seaslog ----------"
    printf "\n" | pecl install seaslog
    docker-php-ext-enable seaslog
fi

if [[ -z "${EXTENSIONS##*,varnish,*}" ]]; then
    echo "---------- Install varnish ----------"
	apk add --no-cache varnish
    printf "\n" | pecl install varnish
    docker-php-ext-enable varnish
fi

if [[ -z "${EXTENSIONS##*,pdo_sqlsrv,*}" ]]; then
    isPhpVersionGreaterOrEqual 7 1
    if [[ "$?" = "1" ]]; then
        echo "---------- Install pdo_sqlsrv ----------"
        apk add --no-cache unixodbc-dev
        printf "\n" | pecl install pdo_sqlsrv
        docker-php-ext-enable pdo_sqlsrv
    else
        echo "pdo_sqlsrv requires PHP >= 7.1.0, installed version is ${PHP_VERSION}"
    fi
fi

if [[ -z "${EXTENSIONS##*,sqlsrv,*}" ]]; then
    isPhpVersionGreaterOrEqual 7 1
    if [[ "$?" = "1" ]]; then
        echo "---------- Install sqlsrv ----------"
        apk add --no-cache unixodbc-dev
        printf "\n" | pecl install sqlsrv
        docker-php-ext-enable sqlsrv
    else
        echo "pdo_sqlsrv requires PHP >= 7.1.0, installed version is ${PHP_VERSION}"
    fi
fi

if [[ -z "${EXTENSIONS##*,mcrypt,*}" ]]; then
    isPhpVersionGreaterOrEqual 7 2
    if [[ "$?" = "1" ]]; then
        echo "---------- mcrypt was REMOVED from PHP 7.2.0 ----------"
    else
        echo "---------- Install mcrypt ----------"
        apk add --no-cache libmcrypt-dev \
        && docker-php-ext-install ${MC} mcrypt
    fi
fi

if [[ -z "${EXTENSIONS##*,mysql,*}" ]]; then
    isPhpVersionGreaterOrEqual 7 0

    if [[ "$?" = "1" ]]; then
        echo
        echo "---------- mysql was REMOVED from PHP 7.0.0 ----------"
        echo
    else
        echo "---------- Install mysql ----------"
        docker-php-ext-install ${MC} mysql
    fi
fi

if [[ -z "${EXTENSIONS##*,sodium,*}" ]]; then
    isPhpVersionGreaterOrEqual 7 2
    if [[ "$?" = "1" ]]; then
        echo
        echo "Sodium is bundled with PHP from PHP 7.2.0"
        echo
    else
        echo "---------- Install sodium ----------"
        apk add --no-cache libsodium-dev
        docker-php-ext-install ${MC} sodium
	fi
fi

if [[ -z "${EXTENSIONS##*,amqp,*}" ]]; then
    echo "---------- Install amqp ----------"
    apk add --no-cache rabbitmq-c-dev
    printf "\n" | pecl install amqp-1.9.4.tgz
    docker-php-ext-enable amqp
fi

if [[ -z "${EXTENSIONS##*,redis,*}" ]]; then
    echo "---------- Install redis ----------"
    printf "\n" | pecl install redis-4.1.1.tgz
    docker-php-ext-enable redis
fi

if [[ -z "${EXTENSIONS##*,memcached,*}" ]]; then
    echo "---------- Install memcached ----------"
    apk add --no-cache libmemcached-dev zlib-dev
    isPhpVersionGreaterOrEqual 7 0

    if [[ "$?" = "1" ]]; then
        printf "\n" | pecl install memcached-3.1.3
    else
        printf "\n" | pecl install memcached-2.2.0
    fi

    docker-php-ext-enable memcached
fi

if [[ -z "${EXTENSIONS##*,xdebug,*}" ]]; then
    echo "---------- Install xdebug ----------"
    isPhpVersionGreaterOrEqual 7 0

    if [[ "$?" = "1" ]]; then
        printf "\n" | pecl install xdebug-2.6.1.tgz
    else
        printf "\n" | pecl install xdebug-2.5.5.tgz
    fi

    docker-php-ext-enable xdebug
fi

if [[ -z "${EXTENSIONS##*,event,*}" ]]; then
    echo "---------- Install event ----------"
    export is_sockets_installed=$(php -r "echo extension_loaded('sockets');")

    if [[ "${is_sockets_installed}" = "" ]]; then
        echo "---------- event is depend on sockets, install sockets first ----------"
        docker-php-ext-install sockets
    fi

    echo "---------- Install event again ----------"
    printf "\n" | pecl install event-2.5.3.tgz
    docker-php-ext-enable --ini-name event.ini event
fi

if [[ -z "${EXTENSIONS##*,mongodb,*}" ]]; then
    echo "---------- Install mongodb ----------"
    printf "\n" | pecl install mongodb-1.5.5.tgz
    docker-php-ext-enable  mongodb
fi

if [[ -z "${EXTENSIONS##*,yaf,*}" ]]; then
    echo "---------- Install yaf ----------"
    isPhpVersionGreaterOrEqual 7 0

    if [[ "$?" = "1" ]]; then
        printf "\n" | pecl install yaf
    else
        # install by pecl may cause error:
        # can't create directory 'configs/.libs': No such file or directory
        mkdir yaf
        tar -xf yaf-2.3.5.tgz -C yaf --strip-components=1
        ( cd yaf && phpize && ./configure && make ${MC} && make install )
    fi

    docker-php-ext-enable yaf
fi

if [[ -z "${EXTENSIONS##*,swoole,*}" ]]; then
    echo "---------- Install swoole ----------"
    isPhpVersionGreaterOrEqual 7 0

    if [[ "$?" = "1" ]]; then
        printf "\n" | pecl install swoole-4.4.2.tgz
    else
        printf "\n" | pecl install swoole-2.0.11.tgz
    fi

    docker-php-ext-enable swoole
fi

if [[ -z "${EXTENSIONS##*,zip,*}" ]]; then
    echo "---------- Install zip ----------"
    isPhpVersionGreaterOrEqual 7 3

    # Fix: https://github.com/docker-library/php/issues/797
    if [[ "$?" = "1" ]]; then
        apk add --no-cache libzip-dev
        docker-php-ext-configure zip --with-libzip=/usr/include
    fi

	docker-php-ext-install ${MC} zip
fi