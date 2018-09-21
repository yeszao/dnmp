<?php

echo '<h1 style="text-align: center;">欢迎使用DNMP！</h1>';

echo '<h2>版本信息</h2>';
echo '<p>PHP版本：<code>', phpversion(), '</code></p>';
echo '<p>Nginx版本：<code>', $_SERVER['SERVER_SOFTWARE'], '</code></p>';
echo '<p>MySQL版本：<code>', getMysqlVersion(), '</code></p>';
echo '<p>Redis版本：<code>', getRedisVersion(), '</code></p>';

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
    $extensions = get_loaded_extensions();
    foreach ($extensions as $i => $e) {
        echo $i + 1, '. ', $e, '<br />';
    }
}

