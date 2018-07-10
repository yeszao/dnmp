# dnmp
Docker deploying Nginx MySQL PHP7 in one key, support full feature functions.

![Demo Image](./dnmp.png)

## 1. Feature
1. Completely open source.
2. Support Multiple PHP version(PHP5.4, PHP5.6, PHP7.2) switch.
3. Support Multiple domains.
4. Support HTTPS and HTTP/2.
5. PHP source located in host.
6. MySQL data directory in host.
7. All conf files located in host.
8. All log files located in host.
9. Built-in PHP extensions install commands.
10. Promise 100% available.
11. Supported any OS with docker.

## 2. Usage
1. Install `git`, `docker` and `docker-compose`;
2. Clone project:
    ```
    $ git clone https://github.com/yeszao/dnmp.git
    ```
4. Start docker containers:
    ```
    $ cd dnmp
    $ docker-compose up
    ```
    You may need use `sudo` before this command in Linux.
5. Go to your browser and type `localhost`, you will see:

![Demo Image](./snapshot.png)

The index file is located in `./www/site1/`.

## 3. Other PHP version?
Default, we start LATEST PHP version by using:
```
$ docker-compose up
```
we can also start PHP5.4 or PHP5.6 by using:
```
$ docker-compose -f docker-compose54.yml up
$ docker-compose -f docker-compose56.yml up
```
We need not change any other files, such as nginx config file or php.ini, everything will work fine in current environment (except code compatibility error).

> Notice: We can only start one php version, for they using same port. We must STOP the running project then START the other one.

## 4. HTTPS and HTTP/2
Default demo include 2 sites:
* http://www.site1.com (same with http://localhost)
* https://www.site2.com

To preview them, add 2 lines to your hosts file (at `/etc/hosts` on Linux and `C:\Windows\System32\drivers\etc\hosts` on Windows):
```
127.0.0.1 www.site1.com
127.0.0.1 www.site2.com
```
Then you can visit from browser.


## 5. Use log
We can identify log directory in nginx / php / php-fpm / mysql config file.
To display the log file in host, we should config them to `/var/log/dnmp`.

But, there are some differences:

### 5.1 Nginx log
Nginx will auto generate all log files.

### 5.2 PHP-FPM log
To use `php-fpm` log, you must create log file manually(in host):
```bash
$ touch log/php.fpm.error.log
$ chmod a+w log/php.fpm.error.log
```
### 5.3 MySQL log
Same as `php-fpm`, log file must be created manually(in host):
```bash
$ touch log/mysql.slow.log
$ chmod a+w log/mysql.slow.log
```

## 6. License
MIT