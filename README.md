# dnmp
Docker deploying Nginx MySQL PHP7 in one key, support full feature functions.

### Feature
1. Support Multiple domains.
2. Support HTTPS and HTTP/2.
3. Support PHP7, Nginx and MySQL version latest.
4. PHP source located in host.
5. MySQL data directory in host.
6. All conf files located in host.
7. All log files located in host.
8. Built-in PHP extensions install commands.

### Usage
1. Install `git`, `docker` and `docker-compose`;
2. Clone all dlnmp directories and files from Github:
    ```
    $ git clone https://github.com/yeszao/dlnmp.git
    ```
4. Start docker container:
    ```
    $ docker-compose up
    ```
    You may need use `sudo` before this command.
5. Go to your browser and type `localhost`, you will see:
    ![Demo Image](https://github.com/yeszao/dlnmp/raw/master/snapshot.png)
    Change `index.php` in `./www/site1/` for more testing.

### HTTPS and HTTP/2
Demo include 2 sites:
* http://www.site1.com (same as http://localhost)
* https://www.site2.com

To preview them, add following two lines to your hosts file (at `/etc/hosts` on Linux and `C:\Windows\System32\drivers\etc\hosts` on Windows):
```
127.0.0.1 www.site1.com
127.0.0.1 www.site2.com
```
Then you can visit from browser.
