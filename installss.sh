#!/bin/bash

if [ $user != "root" ]
then
    echo "please install with root user !"
    exit
fi

wget http://windy.me/sss/shadowsocks.pp
