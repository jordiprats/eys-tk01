#!/bin/bash

rm -fr /var/lib/mysql/*
/usr/libexec/mariadb-prepare-db-dir %n

/usr/bin/mysqld_safe --basedir=/usr &

mysqladmin ping
MYSQL_ALIVE=$?
while [ $MYSQL_ALIVE -ne 0 ];
do
  sleep 1
  mysqladmin ping
  MYSQL_ALIVE=$?
done

echo "create database demo" | mysql
echo "grant all on demo.* to demo@localhost identified by 'demopassword'" | mysql
echo "create table demo(id int not null auto_increment, name text, primary key (id))" | mysql demo
for i in $(ls /etc); do echo "insert into demo(name) values('$i');"; done | mysql demo

pkill mysqld
