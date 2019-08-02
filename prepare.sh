#!/bin/bash

if [ ! -f "./.MYSQL_PASSWORD" ];then
    openssl rand -base64 18 > "./MYSQL_PASSWORD"
fi

if [ ! -f "./.MYSQL_ROOT_PASSWORD" ];then
    openssl rand -base64 18 > "./MYSQL_ROOT_PASSWORD"
fi
