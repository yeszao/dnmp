<?php
echo 'Site 1<br />';
$pdo = new PDO('mysql:host=mysql;dbname=site1', 'root', '123456');
var_dump($pdo);
phpinfo();
