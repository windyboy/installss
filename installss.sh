#!/bin/bash

#check root user
if [ $USER != "root" ]
then
    echo "please install with root user !"
    exit
fi

#get config file
wget http://windy.me/sss/shadowsocks.pp
wget http://windy.me/sss/shadowsocks.json
wget http://windy.me/sss/shadowsocks.conf
#install puppet repo
wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
dpkg -i puppetlabs-release-precise.deb

apt update
apt upgrade -y
apt install puppet

