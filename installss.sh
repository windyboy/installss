#!/bin/bash

if [ $USER != "root" ]
then
    echo "please install with root user !"
    exit
fi

wget http://windy.me/sss/shadowsocks.pp
wget http://windy.me/sss/shadowsocks.json
wget http://windy.me/sss/shadowsocks.conf

apt update
apt upgrade -y
