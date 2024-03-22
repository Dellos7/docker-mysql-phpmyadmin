#!/bin/bash

mysql_user='root'
mysql_password=`grep ^MYSQL_ROOT_PASSWORD .env | cut -d'=' -f2`
dir='sql'
sql_scripts=`ls -1 $dir | sort`
for f in $sql_scripts
do
    docker exec -i mysql-phpmyadmin_mysql mysql -u $mysql_user -p$mysql_password --default-character-set=utf8mb4 < "$dir/$f"
done