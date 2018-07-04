#!/bin/bash

rm -fr /var/lib/mysql/*
/usr/libexec/mariadb-prepare-db-dir %n

/usr/bin/mysqld_safe --basedir=/usr &

sleep 5
echo "create database demo" | mysql
echo "grant all on demo.* to demo@localhost identified by 'demopassword'" | mysql
echo "create table demo(id int not null auto_increment, name text, primary key (id))" | mysql demo
for i in $(ls /etc); do echo "insert into demo(name) values('$i');"; done | mysql demo
