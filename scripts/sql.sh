#!/bin/bash

sql_script='exec.sql'
mysql_user='root'
mysql_password=`grep ^MYSQL_ROOT_PASSWORD .env | cut -d'=' -f2`

if [ -f $sql_script ]
then
    docker exec -i mysql-phpmyadmin_mysql mysql -u $mysql_user -p$mysql_password --default-character-set=utf8mb4 < $sql_script
fi