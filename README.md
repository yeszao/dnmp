# dlnmp
Completely LNMP environment for ONE KEY deploying.

### Feature
1. Multiple domains support.
2. HTTPS and HTTP/2 support.
3. PHP source located in host.
4. MySQL data directory in host.
5. All conf files located in host.
6. All log files located in host.

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
