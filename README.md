DNMP（Docker + Nginx + MySQL + PHP7/5）是一款全功能的**LNMP一键安装程序**。

DNMP项目特点：
1. `100%`开源
2. `100%`遵循Docker标准
2. 支持**多版本PHP**随意切换（PHP5.4、PHP5.6、PHP7.2)
3. 支持绑定任意**多个域名**
4. 支持**HTTPS和HTTP/2**
5. PHP源代码位于host中
6. MySQL data位于host中
7. 所有配置文件可在host中直接修改
8. 所有日志文件可在host中直接查看
9. 内置**完整PHP扩展安装**命令
10. 实际项目中应用，确保`100%`可用
11. 一次配置，**Windows、Linux、MacOs**皆可用

## 1.项目结构
目录说明：
```
/
├── conf                    配置文件目录
│   ├── conf.d              Nginx用户站点配置目录
│   ├── nginx.conf          Nginx默认配置文件
│   ├── mysql.cnf           MySQL用户配置文件
│   ├── php-fpm.conf        PHP-FPM配置文件（部分会覆盖php.ini配置）
│   └── php.ini             PHP默认配置文件
├── docker-compose54.yml    PHP5.4 docker-compose项目文件
├── docker-compose56.yml    PHP5.6 docker-compose项目文件
├── docker-compose.yml      PHP最新版docker-compose项目文件
├── log                     Nginx日志目录
├── mysql                   MySQL数据目录
├── php                     PHP各版本的Dockerfile目录
└── www                     PHP代码目录
```
结构示意图：

![Demo Image](./dnmp.png)


## 2. 快速使用
1. 本地安装`git`、`docker`和`docker-compose`。
2. `clone`项目：
    ```
    $ git clone https://github.com/yeszao/dnmp.git
    ```
3. 如果不是`root`用户，还需将当前用户加入`docker`用户组：
    ```
    $ sudo gpasswd -a ${USER} docker
    ```
4. 启动：
    ```
    $ cd dnmp
    $ docker-compose up
    ```
5. 在浏览器中访问 `localhost`，会看到类似如下的输出：

![Demo Image](./snapshot.png)

这是项目的演示效果，PHP代码在这个目录：`./www/site1/`。


## 3. 使用其他PHP版本？
默认情况下，我们启动的是**最新版本的PHP**，命令如下：
```
$ docker-compose up
```
在`docker-compose stop`后，我们可以用下面的命令启动**PHP5.4**或**PHP5.6**:
```
$ docker-compose -f docker-compose54.yml up
$ docker-compose -f docker-compose56.yml up
```
如果该版本是第一次启动，那么还需要加上`--build`参数构建，不然还是会启动最新版本：
```
$ docker-compose -f docker-compose54.yml up --build
$ docker-compose -f docker-compose56.yml up --build
```
在版本切换时，我们不需要修改任何配置文件，包括Nginx配置文件和php.ini等，
除非是代码兼容错误，否则切换版本后应该都能正常工作。

> 注意：因为所有PHP版本使用的是同一个端口配置，所以我们同时只能使用一个版本，要切换到另外一个版本，必须先停止原来的版本。


## 4. HTTPS和HTTP/2
本项目的演示站点有两个：
* http://www.site1.com (同 http://localhost)
* https://www.site2.com

要预览这两个站点，请在主机的`hosts`文件中加上如下两行：
```
127.0.0.1 www.site1.com
127.0.0.1 www.site2.com
```

* Linux和Mac的`hosts`文件位置： `/etc/hosts`
* Windows的`hosts`文件位置： `C:\Windows\System32\drivers\etc\hosts`

然后通过浏览器这两个地址就能看到效果，其中：

* Site1和localhost是同一个站点，是经典的http站，
* Site2是自定义证书的https站点，浏览器会有安全提示，忽略提示访问即可。


## 5. 使用Log

Log文件生成的位置依赖于conf下各log配置的值。

### 5.1 Nginx日志
Nginx日志是我们用得最多的日志，所以我们单独放在根目录`log`下。

`log`会目录映射Nginx容器的`/var/log/dnmp`目录，所以在Nginx配置文件中，需要输出log的位置，我们需要配置到`/var/log/dnmp`目录，如：
```
error_log  /var/log/dnmp/nginx.site1.error.log  warn;
```


### 5.1 PHP-FPM日志
大部分情况下，PHP-FPM的日志都会输出到Nginx的日志中，所以不需要额外配置。

如果确实需要，可按一下步骤开启。

1. 在主机中创建日志文件并修改权限：
    ```bash
    $ touch log/php-fpm.error.log
    $ chmod a+w log/php-fpm.error.log
    ```
2. 主机上打开并修改PHP-FPM的配置文件`conf/php-fpm.conf`，找到如下一行，删除注释，并改值为：
    ```
    php_admin_value[error_log] = /var/log/dnmp/php-fpm.error.log
    ```
3. 重启PHP-FPM容器。

### 5.2 MySQL日志
因为MySQL容器中的MySQL使用的是`mysql`用户启动，它无法自行在`/var/log`下的增加日志文件。所以，我们把MySQL的日志放在与data一样的目录，即项目的`mysql`目录下，对应容器中的`/var/lib/mysql/`目录。
```bash
slow-query-log-file     = /var/lib/mysql/mysql.slow.log
log-error               = /var/lib/mysql/mysql.error.log
```
以上是mysql.conf中的日志文件的配置。

## 6. 使用composer
dnmp默认已经在容器中安装了composer，使用时先进入容器：
```
$ docker exec -it dnmp_php_1 /bin/bash
```
然后进入相应目录，使用composer：
```
# cd /var/www/html/site1
# composer update
```
因为composer依赖于PHP，所以，是必须在容器里面操作composer的。

## 7. phpmyadmin和phpredisadmin
本项目默认在`docker-compose.yml`中开启了用于MySQL在线管理的*phpMyAdmin*，以及用于redis在线管理的*phpRedisAdmin*，可以根据需要修改或删除。

### 7.1 phpMyAdmin
phpMyAdmin容器映射到主机的端口地址是：`8080`，所以主机上访问phpMyAdmin的地址是：
```
http://localhost:8080
```

MySQL连接信息：
- host：(本项目的MySQL容器网络)
- port：`3306`
- username：（手动在phpmyadmin界面输入）
- password：（手动在phpmyadmin界面输入）

### 7.2 phpRedisAdmin
phpRedisAdmin容器映射到主机的端口地址是：`8081`，所以主机上访问phpMyAdmin的地址是：
```
http://localhost:8081
```

Redis连接信息如下：
- host: (本项目的Redis容器网络)
- port: `6379`


## 8 使用XDEBUG调试
默认情况下，我们已经安装了Xdebug扩展，但并未在php.ini中配置启用。

要使用xdebug调试，在php.ini文件最后加上这几行：
```
[XDebug]
xdebug.remote_enable = 1
xdebug.remote_handler = "dbgp"
xdebug.remote_host = "172.17.0.1"
xdebug.remote_port = 9000
xdebug.remote_log = "/var/log/dnmp/php.xdebug.log"
```
然后重启PHP容器。

## 常见问题
1. 遇到“No releases available for package "pecl.php.net/redis”
    > 请参考： https://github.com/yeszao/dnmp/issues/10

说明：**这个问题主要是受国内网络环境影响，现在PHP7以上的版本直接采用从源码安装扩展，所以这个问题已经没有了。**

2. PHP5.6错误“ibfreetype6-dev : Depends: zlib1g-dev but it is not going to be installed or libz-dev”
    > 请参考： https://github.com/yeszao/dnmp/issues/39

## License
MIT


