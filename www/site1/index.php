<?php

echo '<h1 style="text-align: center;">欢迎使用DNMP！</h1>';
echo '<h2>版本信息</h2>';

echo '<ul>';
echo '<li>PHP版本：<code>', PHP_VERSION, '</code></li>';
echo '<li>Nginx版本：<code>', $_SERVER['SERVER_SOFTWARE'], '</code></li>';
echo '<li>MySQL服务器版本：<code>', getMysqlVersion(), '</code></li>';
echo '<li>Redis服务器版本：<code>', getRedisVersion(), '</code></li>';
echo '</ul>';

echo '<h2>已安装扩展</h2>';
printExtensions();


/**
 * 获取MySQL版本
 */
function getMysqlVersion()
{
    if (extension_loaded('PDO_MYSQL')) {
        try {
            $dbh = new PDO('mysql:host=mysql;dbname=mysql', 'root', '123456');
            $sth = $dbh->query('SELECT VERSION() as version');
            $info = $sth->fetch();
        } catch (PDOException $e) {
            echo "Error!: ", $e->getMessage(), "<br/>";
        }
        return $info['version'];
    } else {
        return 'PDO_MYSQL 扩展未安装 ×';
    }

}

/**
 * 获取Redis版本
 */
function getRedisVersion()
{
    if (extension_loaded('redis')) {
        $redis = new Redis();
        $redis->connect('redis', 6379);
        $info = $redis->info();
        return $info['redis_version'];
    } else {
        return 'Redis 扩展未安装 ×';
    }
}

/**
 * 获取已安装扩展列表
 */
function printExtensions()
{
    echo '<ol>';
    foreach (get_loaded_extensions() as $i => $name) {
        echo "<li>", $name, '=<code>', phpversion($name), '</code></li>';
    }
    echo '</ol>';
}

