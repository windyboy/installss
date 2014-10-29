#!/bin/bash
#check root user
if [ $USER != "root" ]
then
    echo "please install with root user !"
    exit
fi
#check config directory
if [ ! -d "/tmp/sss" ]
then 
    echo "create config directory"
    mkdir /tmp/sss
else
    echo "remove old config directory and create new one"
    rm -rf /tmp/sss
    mkdir /tmp/sss
fi
cd sss
dir=$(pwd)

echo "system setting"
#get config file
wget http://windy.me/sss/shadowsocks.pp
sed -i "s@home@$dir@" shadowsocks.pp 
wget http://windy.me/sss/shadowsocks.json
read -p "Please input shadowsocks server password:" pw
if [ pw = "" ]
then 
    echo "password can not be null, reset to default 'windyboy'"
    pw="windyboy"
fi
sed -i "s@windyboy@$pw@" shadowsocks.json
port=8765
read -p "Please input server port:" port
re='^[0-9]+$'
if ![[$port =~ $re ]]; then
    echo "server port must be number, reset to default '8765'"
    port=8765
fi
sed -i "s@8765@$port@" shadowsocks.json

#wget http://windy.me/sss/shadowsocks.conf
#install puppet repo
#wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
#dpkg -i puppetlabs-release-precise.deb

#apt update
#apt upgrade -y
#apt install puppet

cd ..


#rm -rf sss

#get public ip address
pia=$(wget -qO- http://ipecho.net/plain)
echo "public ip address:$pia"

echo ""
