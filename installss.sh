#!/bin/bash

if [ $user != "root" ]
then
    echo "please install with root user !"
    exit

wget http://windy.me/sss/shadowsocks.pp
