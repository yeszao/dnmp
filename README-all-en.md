DNMP (Docker + Nginx/Openresty + MySQL5, 8 + PHP5, 7,8 + Redis + ElasticSearch + MongoDB + RabbitMQ) is a full-featured model**LNMP one-click installer with Support for Arm CPUs**。

> It is best to read it in advance before use[directory](#目录), in order to get started quickly, and problems can be eliminated in time.

QQ Exchange Group:

*   Group 1:**572041090**(Full)
*   Group 2:**300723526**(Full)
*   Group 3:**878913761**(bit)

**[\[ENGLISH\]](README-en.md)** -
[**\[GitHub Address\]**](https://github.com/yeszao/dnmp) -
[**\[Gitee address\]**](https://gitee.com/yeszao/dnmp)

DNMP Project Features:

1.  `100%`open source
2.  `100%`Follow docker standards
3.  backing**Multiple versions of PHP**Coexistence, can be switched arbitrarily (PHP5.4, PHP5.6, PHP7.1, PHP7.2, PHP7.3, PHP7.4, PHP8.0)
4.  Binding is supported**Any number of domain names**
5.  backing**HTTPS and HTTP/2**
6.  **PHP source code, MySQL data, configuration files, log files**All can be directly modified in Host
7.  Built**Full PHP extension installation**command
8.  Supported by default`pdo_mysql`、`mysqli`、`mbstring`、`gd`、`curl`、`opcache`and other commonly used and popular extensions, flexibly configured according to the environment
9.  One-click selection of common services:
    *   Multiple PHP versions: PHP5.4, PHP5.6, PHP7.0-7.4, PHP8.0
    *   Web services: Nginx, Openresty
    *   Databases: MySQL5, MySQL8, Redis, memcached, MongoDB, ElasticSearch
    *   Message Queuing: RabbitMQ
    *   Accessibility: Kibana, Logstash, phpMyAdmin, phpRedisAdmin, AdminMongo
10. Apply in real projects, ensure`100%`available
11. All mirrors originate from[Docker official repository](https://hub.docker.com), safe and reliable
12. One configuration,**Windows、Linux、MacOs**All available
13. Supports quick installation extension commands `install-php-extensions apcu`
14. Supports installing CERTBOT to obtain SSL certificates for free https

# directory

*   [1. Directory structure](#1目录结构)
*   [2. Quick to use](#2快速使用)
*   [3.PHP and extensions](#3PHP和扩展)
    *   [3.1 Switch the PHP version used by Nginx](#31-切换Nginx使用的PHP版本)
    *   [3.2 Install PHP extensions](#32-安装PHP扩展)
    *   [3.3 Quickly install php extensions](#33-快速安装php扩展)
    *   [3.4 Using php command line in Host (php-cli)](#34-host中使用php命令行php-cli)
    *   [3.5 Use commoser](#35-使用composer)
*   [4. Administrative commands](#4管理命令)
    *   [4.1 Server Startup and Build Commands](#41-服务器启动和构建命令)
    *   [4.2 Add shortcut commands](#42-添加快捷命令)
*   [5. Use Log](#5使用log)
    *   [5.1 Nginx logs](#51-nginx日志)
    *   [5.2 PHP-FPM logs](#52-php-fpm日志)
    *   [5.3 MySQL logs](#53-mysql日志)
*   [6. Database management](#6数据库管理)
    *   [6.1 phpMyAdmin](#61-phpmyadmin)
    *   [6.2 phpRedisAdmin](#62-phpredisadmin)
*   [7. Safe to use in a formal environment](#7在正式环境中安全使用)
*   [8. Frequently Asked Questions](#8常见问题)
    *   [8.1 How to use curl in PHP code?](#81-如何在php代码中使用curl)
    *   [8.2 Docker uses cron to time tasks](#82-Docker使用cron定时任务)
    *   [8.3 Docker container time](#83-Docker容器时间)
    *   [8.4 How to connect to MySQL and Redis servers](#84-如何连接MySQL和Redis服务器)

## 1. Directory structure

    /
    ├── data                        数据库数据目录
    │   ├── esdata                  ElasticSearch 数据目录
    │   ├── mongo                   MongoDB 数据目录
    │   ├── mysql                   MySQL8 数据目录
    │   └── mysql5                  MySQL5 数据目录
    ├── services                    服务构建文件和配置文件目录
    │   ├── elasticsearch           ElasticSearch 配置文件目录
    │   ├── mysql                   MySQL8 配置文件目录
    │   ├── mysql5                  MySQL5 配置文件目录
    │   ├── nginx                   Nginx 配置文件目录
    │   ├── php                     PHP5.6 - PHP7.4 配置目录
    │   ├── php54                   PHP5.4 配置目录
    │   └── redis                   Redis 配置目录
    ├── logs                        日志目录
    ├── docker-compose.sample.yml   Docker 服务配置示例文件
    ├── env.smaple                  环境配置示例文件
    └── www                         PHP 代码目录

## 2. Quick to use

1.  Local installation
    *   `git`
    *   `Docker`(The system needs to be Linux, Windows 10 Build 15063+, or MacOS 10.12+, and must be.)`64`bit)
    *   `docker-compose 1.7.0+`
2.  `clone`Project:
        $ git clone https://github.com/yeszao/dnmp.git
        # 假如速度太慢，可以使用加速拉取镜像
        $ git clone https://github.com.cnpmjs.org/yeszao/dnmp.git
3.  If the host is a Linux system and the current user is not`root`Users, you also need to join the current user`docker`User Groups:
        $ sudo gpasswd -a ${USER} docker
4.  Copy and name the configuration file (for Windows systems.)`copy`command), start:
        $ cd dnmp                                           # 进入项目目录
        $ cp env.sample .env                                # 复制环境变量文件
        $ cp docker-compose.sample.yml docker-compose.yml   # 复制 docker-compose 配置文件。默认启动3个服务：
                                                            # Nginx、PHP7和MySQL8。要开启更多其他服务，如Redis、
                                                            # PHP5.6、PHP5.4、MongoDB，ElasticSearch等，请删
                                                            # 除服务块前的注释
        $ docker-compose up                                 # 启动
5.  Access in a browser:`http://localhost`or`https://localhost`(Self-signed HTTPS demo) can see the effect of PHP code in the file`./www/localhost/index.php`。

## 3.PHP and extensions

### 3.1 Switch the PHP version used by Nginx

First, you need to start another version of PHP, such as PHP 5.4, so that's the first step`docker-compose.yml`Delete the comments that preceded PHP5.4 from the file and start the PHP5.4 container.

After PHP5.4 starts, open Nginx Configuration and modify it`fastcgi_pass`The host address of the company, by `php`to`php54`As follows:

        fastcgi_pass   php:9000;

For:

        fastcgi_pass   php54:9000;

thereinto `php` and `php54` be`docker-compose.yml`The name of the server in the file.

At last**Reboot Nginx** Take effect.

```bash
$ docker exec -it nginx nginx -s reload
```

Here are two`nginx`, the first is the container name, and the second is in the container`nginx`Procedure.

### 3.2 Install PHP extensions

Many of php's features are implemented through extensions, and installing extensions is a slightly time-consuming process.
So, in addition to the PHP built-in extension, in`env.sample`In the file we only install a small number of extensions by default,
If you want to install more extensions, open yours`.env`Modify the following PHP configuration,
Add the required PHP extensions:

```bash
PHP_EXTENSIONS=pdo_mysql,opcache,redis       # PHP 要安装的扩展列表，英文逗号隔开
PHP54_EXTENSIONS=opcache,redis                 # PHP 5.4要安装的扩展列表，英文逗号隔开
```

Then re-build the PHP image.

```bash
docker-compose build php
```

See the available extensions in the same file`env.sample`Comment block description.

### 3.3 Quickly install php extensions

1\. Enter the container:

```sh
docker exec -it php /bin/sh

install-php-extensions apcu 
```

2\. Support quick installation extension list

<!-- START OF EXTENSIONS TABLE -->

<!-- ########################################################### -->

<!-- #                                                         # -->

<!-- #  DO NOT EDIT THIS TABLE: IT IS GENERATED AUTOMATICALLY  # -->

<!-- #                                                         # -->

<!-- #  EDIT THE data/supported-extensions FILE INSTEAD        # -->

<!-- #                                                         # -->

<!-- ########################################################### -->

| Extension | PHP 5.5 | PHP 5.6 | PHP 7.0 | PHP 7.1 | PHP 7.2 | PHP 7.3 | PHP 7.4 | PHP 8.0 | PHP 8.1 |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| amqp | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| apcu | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| apcu_bc |  |  | ✓ | ✓ | ✓ | ✓ | ✓ |  |  |
| ast |  |  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| bcmath | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| blackfire | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| bz2 | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| calendar | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| cmark |  |  | ✓ | ✓ | ✓ | ✓ | ✓ |  |  |
| csv |  |  |  |  |  | ✓ | ✓ | ✓ | ✓ |
| dba | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| decimal |  |  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| ds |  |  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| enchant | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| ev | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| event | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| excimer |  |  |  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| exif | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| ffi |  |  |  |  |  |  | ✓ | ✓ | ✓ |
| gd | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| gearman | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |  |
| geoip | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |  |  |
| geospatial | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| gettext | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| gmagick | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| gmp | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| gnupg | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| grpc | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| http | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| igbinary | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| imagick | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| imap | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| inotify | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| interbase | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |  |  |  |
| intl | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| ioncube_loader | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |  |  |
| jsmin | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |  |  |
| json_post | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| ldap | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| lzf | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| mailparse | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| maxminddb |  |  |  |  | ✓ | ✓ | ✓ | ✓ | ✓ |
| mcrypt | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| memcache | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| memcached | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| mongo | ✓ | ✓ |  |  |  |  |  |  |  |
| mongodb | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| mosquitto | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |  |  |
| msgpack | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| mssql | ✓ | ✓ |  |  |  |  |  |  |  |
| mysql | ✓ | ✓ |  |  |  |  |  |  |  |
| mysqli | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| oauth | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| oci8 | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| odbc | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| opcache | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| opencensus |  |  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| openswoole |  |  |  |  | ✓ | ✓ | ✓ | ✓ | ✓ |
| parallel[\*](#special-requirements-for-parallel) |  |  |  | ✓ | ✓ | ✓ | ✓ |  |  |
| pcntl | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| pcov |  |  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| pdo_dblib | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |  |
| pdo_firebird | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| pdo_mysql | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| pdo_oci |  |  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| pdo_odbc | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| pdo_pgsql | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| pdo_sqlsrv[\*](#special-requirements-for-pdo_sqlsrv) |  |  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| pgsql | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| propro | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |  |  |
| protobuf | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |  |
| pspell | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| pthreads[\*](#special-requirements-for-pthreads) | ✓ | ✓ | ✓ |  |  |  |  |  |  |
| raphf | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| rdkafka | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| recode | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |  |  |  |
| redis | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| seaslog | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| shmop | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| smbclient | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| snmp | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| snuffleupagus |  |  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| soap | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| sockets | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| solr | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| sourceguardian | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |  |
| spx |  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| sqlsrv[\*](#special-requirements-for-sqlsrv) |  |  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| ssh2 | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| stomp | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |  |  |
| swoole | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| sybase_ct | ✓ | ✓ |  |  |  |  |  |  |  |
| sysvmsg | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| sysvsem | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| sysvshm | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| tensor[\*](#special-requirements-for-tensor) |  |  |  |  | ✓ | ✓ | ✓ | ✓ |  |
| tidy | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| timezonedb | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| uopz | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| uploadprogress | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| uuid | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| vips[\*](#special-requirements-for-vips) |  |  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| wddx | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |  |  |  |
| xdebug | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| xhprof | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| xlswriter |  |  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| xmldiff | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| xmlrpc | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| xsl | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| yac |  |  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| yaml | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| yar | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| zephir_parser |  |  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| zip | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| zookeeper | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| zstd | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |

*Number of supported extensions: 116*

This extension comes from<https://github.com/mlocati/docker-php-extension-installer>
Refer to the sample files

### 3.4 Using php command line in Host (php-cli)

1.  reference[bash.alias.sample](bash.alias.sample)Sample file, copy the corresponding php cli function to the host `~/.bashrc`File.
2.  To make a file work:
    ```bash
    source ~/.bashrc
    ```
3.  You can then execute php commands in the host:
    ```bash
    ~ php -v
    PHP 7.2.13 (cli) (built: Dec 21 2018 02:22:47) ( NTS )
    Copyright (c) 1997-2018 The PHP Group
    Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
        with Zend OPcache v7.2.13, Copyright (c) 1999-2018, by Zend Technologies
        with Xdebug v2.6.1, Copyright (c) 2002-2018, by Derick Rethans
    ```

### 3.5 Use commoser

**Method 1: Use the compare command in the host**

1.  Determine the path to the compiler cache. For example, my dnmp download is in`~/dnmp`directory, that compiler's cache path is`~/dnmp/data/composer`。
2.  reference[bash.alias.sample](bash.alias.sample)A sample file that copies the corresponding php composer function to the host `~/.bashrc`File.
    > It is important to note here that the sample file is in`~/dnmp/data/composer`The directory needs to be the directory identified in the first step.
3.  To make a file work:
    ```bash
    source ~/.bashrc
    ```
4.  You can use a composer in any directory on the host:
    ```bash
    cd ~/dnmp/www/
    composer create-project yeszao/fastphp project --no-dev
    ```
5.  Optionally, the first time you use composer, it will be `~/dnmp/data/composer` Generate one under the directory**config.json**file, in which you can specify a domestic repository, for example:
    ```json
    {
        "config": {},
        "repositories": {
            "packagist": {
                "type": "composer",
                "url": "https://mirrors.aliyun.com/composer/"
            }
        }
    }

    ```

**Method 2: Use the composer command inside the container**

There is another way, which is to go into the container and execute`composer`Command, using the PHP7 container as an example:

```bash
docker exec -it php /bin/sh
cd /www/localhost
composer update
```

## 4. Administrative commands

### 4.1 Server Startup and Build Commands

To manage services, follow the command with the server name, for example:

```bash
$ docker-compose up                         # 创建并且启动所有容器
$ docker-compose up -d                      # 创建并且后台运行方式启动所有容器
$ docker-compose up nginx php mysql         # 创建并且启动nginx、php、mysql的多个容器
$ docker-compose up -d nginx php  mysql     # 创建并且已后台运行的方式启动nginx、php、mysql容器


$ docker-compose start php                  # 启动服务
$ docker-compose stop php                   # 停止服务
$ docker-compose restart php                # 重启服务
$ docker-compose build php                  # 构建或者重新构建服务

$ docker-compose rm php                     # 删除并且停止php容器
$ docker-compose down                       # 停止并删除容器，网络，图像和挂载卷
```

### 4.2 Add shortcut commands

At the time of development, we may use it often`docker exec -it`Entering the container and aliasing the commands commonly used is a convenient way to do so.

First, review the available containers in the host:

```bash
$ docker ps           # 查看所有运行中的容器
$ docker ps -a        # 所有容器
```

Output`NAMES`That column is the name of the container, or if the default configuration is used, then the name is`nginx`、`php`、`php56`、`mysql`Wait.

Then, open`~/.bashrc`or`~/.zshrc`file, plus:

```bash
alias dnginx='docker exec -it nginx /bin/sh'
alias dphp='docker exec -it php /bin/sh'
alias dphp56='docker exec -it php56 /bin/sh'
alias dphp54='docker exec -it php54 /bin/sh'
alias dmysql='docker exec -it mysql /bin/bash'
alias dredis='docker exec -it redis /bin/sh'
```

The next time you enter the container, it is very fast, such as entering the php container:

```bash
$ dphp
```

### 4.3 View docker networks

```sh
ifconfig docker0
```

For filling in`extra_hosts`The container accesses the host`hosts`address

## 5. Use Log

The location where the log file is generated depends on the value of each log configuration under conf.

### 5.1 Nginx logs

Nginx logs are the logs we use the most, so we put them separately in the root directory`log`Under.

`log`The directory will be mapped for the Nginx container`/var/log/nginx`directory, so in the Nginx configuration file, the location of the output log needs to be configured`/var/log/nginx`Directories, such as:

    error_log  /var/log/nginx/nginx.localhost.error.log  warn;

### 5.2 PHP-FPM logs

In most cases, PHP-FPM logs are output to Nginx's logs, so no additional configuration is required.

In addition, it is recommended to open the error log directly in PHP:

```php
error_reporting(E_ALL);
ini_set('error_reporting', 'on');
ini_set('display_errors', 'on');
```

If you really need it, you can open it (in a container) by following the steps below.

1.  Go to the container, create a log file, and modify the permissions:
    ```bash
    $ docker exec -it php /bin/sh
    $ mkdir /var/log/php
    $ cd /var/log/php
    $ touch php-fpm.error.log
    $ chmod a+w php-fpm.error.log
    ```
2.  Open and modify the configuration file for PHP-FPM on the host`conf/php-fpm.conf`, find the following line, delete the comment, and change the value to:
        php_admin_value[error_log] = /var/log/php/php-fpm.error.log
3.  Restart the PHP-FPM container.

### 5.3 MySQL logs

Because MySQL in the MySQL container is used`mysql`The user starts, it cannot be self-contained`/var/log`Add log files under Add log files. So, we put mySQL logs in the same directory as data, i.e. projects`mysql`directory, corresponding to the container`/var/log/mysql/`Directory.

```bash
slow-query-log-file     = /var/log/mysql/mysql.slow.log
log-error               = /var/log/mysql/mysql.error.log
```

The above is the configuration of the log file in mysql.conf.

## 6. Database management

This project defaults to `docker-compose.yml`For MySQL online management is not turned on*phpMyAdmin*, and for redis online management*phpRedisAdmin*, which can be modified or deleted as needed.

### 6.1 phpMyAdmin

The port address of the phpMyAdmin container mapped to the host is:`8080`, so the address on the host to access phpMyAdmin is:

    http://localhost:8080

MySQL connection information:

*   host: (MySQL container network for this project)
*   port：`3306`
*   username:(Manually entered in the phpmyadmin interface)
*   password:(Manually entered in the phpmyadmin interface)

### 6.2 phpRedisAdmin

The port address of the phpRedisAdmin container mapped to the host is:`8081`, so the address on the host to access phpMyAdmin is:

    http://localhost:8081

The Redis connection information is as follows:

*   host: (Redis Container Network for this project)
*   port: `6379`

## 7. Safe to use in a formal environment

To use in a formal environment, please:

1.  Turn off XDebug debugging in php .ini
2.  Security policies to enhance Access to MySQL databases
3.  Enhanced security policies for redis access

## 8 Frequently Asked Questions

### 8.1 How to use curl in PHP code?

Refer to this issue:<https://github.com/yeszao/dnmp/issues/91>

### 8.2 Docker uses cron to time tasks

[Docker uses cron to time tasks](https://www.awaimai.com/2615.html)

### 8.3 Docker container time

The container time is configured in an .env file`TZ`For variables, see all supported time zones[List of time zones on Wikipedia](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)or[List of time zones supported by PHP· PHP official website](https://www.php.net/manual/zh/timezones.php)。

### 8.4 How to connect to MySQL and Redis servers

There are two cases of this.

The first case, in**PHP code**。

```php
// 连接MySQL
$dbh = new PDO('mysql:host=mysql;dbname=mysql', 'root', '123456');

// 连接Redis
$redis = new Redis();
$redis->connect('redis', 6379);
```

Because containers are containers`expose`The ports are connected, and they are in the same one`networks`down, so connected`host`Parameters directly with the container name,`port`The parameter is the port inside the container. Please refer to it for more[The Difference Between Docker-compose Ports and Expo](https://www.awaimai.com/2138.html)。

In the second case,**In the host**Pass**command line**or**Navicat**and other tools connected. For the host to connect mysql and redis, the container must pass through`ports`The port is mapped to the host. Take mysql as an example.`docker-compose.yml`There is such a thing in the document`ports`Disposition:`3306:3306`, that is, the 3306 port of the host and the 3306 port of the container form a map, so we can connect like this:

```bash
$ mysql -h127.0.0.1 -uroot -p123456 -P3306
$ redis-cli -h127.0.0.1
```

Over here`host`The parameter cannot be used localhost because it communicates with mysql through the sock file by default, and the container is isolated from the host file system, so it needs to be connected via TCP, so you need to specify the IP.

### 8.5 How php in a container connects to host MySQL

1\. Host execution`ifconfig docker0`get`inet`It's about connecting`ip`address

```sh
$ ifconfig docker0
docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        ...
```

2\. Run the host Mysql command line

```mysql
 mysql>GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
 mysql>flush privileges;
// 其中各字符的含义：
// *.* 对任意数据库任意表有效
// "root" "123456" 是数据库用户名和密码
// '%' 允许访问数据库的IP地址，%意思是任意IP，也可以指定IP
// flush privileges 刷新权限信息
```

3\. Then use the php container directly`172.0.17.1:3306`Just connect

### 8.6 SQLSTATE\[HY000] \[1130] Host '172.19.0.2' is not allowed to connect to this MySQL server

1.  Currently using mysql-server `8.0.28`The above version, php version is required`7.4.7`The above can only be connected

## License

MIT
