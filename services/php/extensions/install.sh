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


if [ "${PHP_EXTENSIONS}" != "" ]; then
    apk --update add --no-cache --virtual .build-deps autoconf g++ libtool make curl-dev gettext-dev linux-headers
fi


export EXTENSIONS=",${PHP_EXTENSIONS},"


#
# Check if current php version is greater than or equal to
# specific version.
#
# For example, to check if current php is greater than or
# equal to PHP 7.0:
#
# isPhpVersionGreaterOrEqual 7 0
#
# Param 1: Specific PHP Major version
# Param 2: Specific PHP Minor version
# Return : 1 if greater than or equal to, 0 if less than
#
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


#
# Install extension from package file(.tgz),
# For example:
#
# installExtensionFromTgz redis-5.2.2
#
# Param 1: Package name with version
# Param 2: enable options
#
installExtensionFromTgz()
{
    tgzName=$1
    para1= 
    extensionName="${tgzName%%-*}"
    
    if [  $2 ]; then  
        para1=$2
    fi  
    mkdir ${extensionName}
    tar -xf ${tgzName}.tgz -C ${extensionName} --strip-components=1
    ( cd ${extensionName} && phpize && ./configure ${para1} && make ${MC} && make install )

    docker-php-ext-enable ${extensionName}
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
    apk --no-cache add gettext-dev
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

if [[ -z "${EXTENSIONS##*,hprose,*}" ]]; then
    echo "---------- Install hprose ----------"
    printf "\n" | pecl install hprose
    docker-php-ext-enable hprose
fi

if [[ -z "${EXTENSIONS##*,gd,*}" ]]; then
    echo "---------- Install gd ----------"
    isPhpVersionGreaterOrEqual 7 4

    if [[ "$?" = "1" ]]; then
        # "--with-xxx-dir" was removed from php 7.4,
        # issue: https://github.com/docker-library/php/issues/912
        options="--with-freetype --with-jpeg --with-webp"
    else
        options="--with-gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-webp-dir=/usr/include/"
    fi

    apk add --no-cache \
        freetype \
        freetype-dev \
        libpng \
        libpng-dev \
        libjpeg-turbo \
        libjpeg-turbo-dev \
	libwebp-dev \
    && docker-php-ext-configure gd ${options} \
    && docker-php-ext-install ${MC} gd \
    && apk del \
        freetype-dev \
        libpng-dev \
        libjpeg-turbo-dev
fi

if [[ -z "${EXTENSIONS##*,yaml,*}" ]]; then
    echo "---------- Install yaml ----------"
    apk add --no-cache yaml-dev
    printf "\n" | pecl install yaml
    docker-php-ext-enable yaml
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
    apk add --no-cache libxml2-dev
	docker-php-ext-install ${MC} soap
fi

if [[ -z "${EXTENSIONS##*,xsl,*}" ]]; then
    echo "---------- Install xsl ----------"
	apk add --no-cache libxml2-dev libxslt-dev
	docker-php-ext-install ${MC} xsl
fi

if [[ -z "${EXTENSIONS##*,xmlrpc,*}" ]]; then
    echo "---------- Install xmlrpc ----------"
	apk add --no-cache libxml2-dev libxslt-dev
	docker-php-ext-install ${MC} xmlrpc
fi

if [[ -z "${EXTENSIONS##*,wddx,*}" ]]; then
    echo "---------- Install wddx ----------"
	apk add --no-cache libxml2-dev libxslt-dev
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

if [[ -z "${EXTENSIONS##*,psr,*}" ]]; then
    echo "---------- Install psr ----------"
    printf "\n" | pecl install psr
    docker-php-ext-enable psr
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


if [[ -z "${EXTENSIONS##*,ssh2,*}" ]]; then
    isPhpVersionGreaterOrEqual 7 0
    if [[ "$?" = "1" ]]; then
        echo "---------- Install ssh2 ----------"
        printf "\n" | apk add libssh2-dev
        pecl install ssh2-1.1.2
        docker-php-ext-enable ssh2
    else
        echo "ssh2 requires PHP >= 7.0.0, installed version is ${PHP_VERSION}"
    fi
fi

if [[ -z "${EXTENSIONS##*,protobuf,*}" ]]; then
    isPhpVersionGreaterOrEqual 7 0
    if [[ "$?" = "1" ]]; then
        echo "---------- Install protobuf ----------"
        printf "\n" | pecl install protobuf
        docker-php-ext-enable protobuf
    else
        echo "yar requires PHP >= 7.0.0, installed version is ${PHP_VERSION}"
    fi
fi

if [[ -z "${EXTENSIONS##*,yac,*}" ]]; then
    isPhpVersionGreaterOrEqual 7 0
    if [[ "$?" = "1" ]]; then
        echo "---------- Install yac ----------"
        printf "\n" | pecl install yac-2.0.2
        docker-php-ext-enable yac
    else
        echo "yar requires PHP >= 7.0.0, installed version is ${PHP_VERSION}"
    fi
fi

if [[ -z "${EXTENSIONS##*,yar,*}" ]]; then
    isPhpVersionGreaterOrEqual 7 0
    if [[ "$?" = "1" ]]; then
        echo "---------- Install yar ----------"
        printf "\n" | pecl install yar
        docker-php-ext-enable yar
    else
        echo "yar requires PHP >= 7.0.0, installed version is ${PHP_VERSION}"
    fi

fi



if [[ -z "${EXTENSIONS##*,yaconf,*}" ]]; then
    isPhpVersionGreaterOrEqual 7 0
    if [[ "$?" = "1" ]]; then
        echo "---------- Install yaconf ----------"
        printf "\n" | pecl install yaconf
        docker-php-ext-enable yaconf
    else
        echo "yar requires PHP >= 7.0.0, installed version is ${PHP_VERSION}"
    fi
fi

if [[ -z "${EXTENSIONS##*,seaslog,*}" ]]; then
    echo "---------- Install seaslog ----------"
    printf "\n" | pecl install seaslog
    docker-php-ext-enable seaslog
fi

if [[ -z "${EXTENSIONS##*,varnish,*}" ]]; then
    echo "---------- Install varnish ----------"
	apk add --no-cache varnish-dev
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
        curl -o /tmp/msodbcsql17_amd64.apk https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql17_17.5.2.1-1_amd64.apk
        apk add --allow-untrusted /tmp/msodbcsql17_amd64.apk
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
    isPhpVersionGreaterOrEqual 7 0
    if [[ "$?" = "1" ]]; then
        echo "---------- Install mcrypt ----------"
        apk add --no-cache libmcrypt-dev libmcrypt re2c
        printf "\n" |pecl install mcrypt
        docker-php-ext-enable mcrypt
    else
        echo "---------- Install mcrypt ----------"
        apk add --no-cache libmcrypt-dev \
        && docker-php-ext-install ${MC} mcrypt
    fi
fi

if [[ -z "${EXTENSIONS##*,mysql,*}" ]]; then
    isPhpVersionGreaterOrEqual 7 0

    if [[ "$?" = "1" ]]; then
        echo "---------- mysql was REMOVED from PHP 7.0.0 ----------"
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
    installExtensionFromTgz amqp-1.10.2
fi

if [[ -z "${EXTENSIONS##*,redis,*}" ]]; then
    echo "---------- Install redis ----------"
    isPhpVersionGreaterOrEqual 7 0
    if [[ "$?" = "1" ]]; then
        installExtensionFromTgz redis-5.2.2
    else
        printf "\n" | pecl install redis-4.3.0
        docker-php-ext-enable redis
    fi
fi

if [[ -z "${EXTENSIONS##*,apcu,*}" ]]; then
    echo "---------- Install apcu ----------"
    installExtensionFromTgz apcu-5.1.17
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

if [[ -z "${EXTENSIONS##*,memcache,*}" ]]; then
    echo "---------- Install memcache ----------"
    isPhpVersionGreaterOrEqual 7 0
    if [[ "$?" = "1" ]]; then
        installExtensionFromTgz memcache-4.0.5.2
    else
        installExtensionFromTgz memcache-2.2.6
    fi
fi

if [[ -z "${EXTENSIONS##*,xdebug,*}" ]]; then
    echo "---------- Install xdebug ----------"
    isPhpVersionGreaterOrEqual 7 0

    if [[ "$?" = "1" ]]; then
        isPhpVersionGreaterOrEqual 7 4
        if [[ "$?" = "1" ]]; then
            installExtensionFromTgz xdebug-2.9.2
        else
            installExtensionFromTgz xdebug-2.6.1
        fi
    else
        installExtensionFromTgz xdebug-2.5.5
    fi
fi

if [[ -z "${EXTENSIONS##*,event,*}" ]]; then
    echo "---------- Install event ----------"
    apk add --no-cache libevent-dev
    export is_sockets_installed=$(php -r "echo extension_loaded('sockets');")

    if [[ "${is_sockets_installed}" = "" ]]; then
        echo "---------- event is depend on sockets, install sockets first ----------"
        docker-php-ext-install sockets
    fi

    echo "---------- Install event again ----------"
    installExtensionFromTgz event-2.5.6  "--ini-name event.ini"
fi

if [[ -z "${EXTENSIONS##*,mongodb,*}" ]]; then
    echo "---------- Install mongodb ----------"
    installExtensionFromTgz mongodb-1.7.4
fi

if [[ -z "${EXTENSIONS##*,yaf,*}" ]]; then
    echo "---------- Install yaf ----------"
    isPhpVersionGreaterOrEqual 7 0

    if [[ "$?" = "1" ]]; then
        printf "\n" | pecl install yaf
        docker-php-ext-enable yaf
    else
        installExtensionFromTgz yaf-2.3.5
    fi
fi


if [[ -z "${EXTENSIONS##*,swoole,*}" ]]; then
    echo "---------- Install swoole ----------"
    # Fix: Refer to the line containing "swoole@alpine)" in file "./install-php-extensions"
    apk add --no-cache libstdc++

    isPhpVersionGreaterOrEqual 7 0

    if [[ "$?" = "1" ]]; then
        installExtensionFromTgz swoole-4.5.2
    else
        installExtensionFromTgz swoole-2.0.11
    fi
fi

if [[ -z "${EXTENSIONS##*,zip,*}" ]]; then
    echo "---------- Install zip ----------"
    # Fix: https://github.com/docker-library/php/issues/797
    apk add --no-cache libzip-dev

    isPhpVersionGreaterOrEqual 7 4
    if [[ "$?" != "1" ]]; then
        docker-php-ext-configure zip --with-libzip=/usr/include
    fi

	docker-php-ext-install ${MC} zip
fi

if [[ -z "${EXTENSIONS##*,xhprof,*}" ]]; then
    echo "---------- Install XHProf ----------"

    isPhpVersionGreaterOrEqual 7 0

    if [[ "$?" = "1" ]]; then
        mkdir xhprof \
        && tar -xf xhprof-2.2.0.tgz -C xhprof --strip-components=1 \
        && ( cd xhprof/extension/ && phpize && ./configure  && make ${MC} && make install ) \
        && docker-php-ext-enable xhprof
    else
       echo "---------- PHP Version>= 7.0----------"
    fi

fi

if [[ -z "${EXTENSIONS##*,xlswriter,*}" ]]; then
    echo "---------- Install xlswriter ----------"
    isPhpVersionGreaterOrEqual 7 0

    if [[ "$?" = "1" ]]; then
        printf "\n" | pecl install xlswriter
        docker-php-ext-enable xlswriter
    else
        echo "---------- PHP Version>= 7.0----------"
    fi
fi

if [[ -z "${EXTENSIONS##*,rdkafka,*}" ]]; then
    echo "---------- Install rdkafka ----------"
    isPhpVersionGreaterOrEqual 5 6

    if [[ "$?" = "1" ]]; then
        apk add librdkafka-dev
        printf "\n" | pecl install rdkafka
        docker-php-ext-enable rdkafka
    else
        echo "---------- PHP Version>= 5.6----------"
    fi
fi

if [[ -z "${EXTENSIONS##*,zookeeper,*}" ]]; then
    echo "---------- Install zookeeper ----------"
    isPhpVersionGreaterOrEqual 7 0

    if [[ "$?" = "1" ]]; then
        apk add re2c
        apk add libzookeeper-dev --repository http://${CONTAINER_PACKAGE_URL}/alpine/edge/testing/
        printf "\n" | pecl install zookeeper
        docker-php-ext-enable zookeeper
    else
        echo "---------- PHP Version>= 7.0----------"
    fi
fi

if [[ -z "${EXTENSIONS##*,phalcon,*}" ]]; then
    echo "---------- Install phalcon ----------"
    isPhpVersionGreaterOrEqual 7 2

    if [[ "$?" = "1" ]]; then
        printf "\n" | pecl install phalcon
        docker-php-ext-enable psr
        docker-php-ext-enable phalcon
    else
        echo "---------- PHP Version>= 7.2----------"
    fi
fi

if [[ -z "${EXTENSIONS##*,sdebug,*}" ]]; then
    echo "---------- Install sdebug ----------"
    isPhpVersionGreaterOrEqual 7 2

    if [[ "$?" = "1" ]]; then
                curl -SL "https://github.com/swoole/sdebug/archive/sdebug_2_9-beta.tar.gz" -o sdebug.tar.gz \
             && mkdir -p sdebug \
             && tar -xf sdebug.tar.gz -C sdebug --strip-components=1 \
             && rm sdebug.tar.gz \
             && ( \
                 cd sdebug \
                 && phpize \
                 && ./configure  --enable-xdebug \
                 && make clean && make && make install \
             ) \
             && docker-php-ext-enable xdebug
    else
        echo "---------- PHP Version>= 7.2----------"
    fi
fi

if [ "${PHP_EXTENSIONS}" != "" ]; then
    apk del .build-deps \
    && docker-php-source delete
fi
