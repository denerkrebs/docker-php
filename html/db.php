<?php

define('DB_HOST', 'db');
define('DB_NAME', 'mydb');
define('DB_USER', 'user');
define('DB_PASSWORD', 'pass');

$connection = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME, 3306) or die (mysqli_error());

if($connection){
    echo "Connected";
}