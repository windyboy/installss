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
echo "get puppet config..."
wget http://windy.me/sss/shadowsocks.pp
sed -i "s@home@$dir@" shadowsocks.pp 
echo "get shadowsocks server config..."
wget http://windy.me/sss/shadowsocks.json
read -p "Please input shadowsocks server password:" pw
if [ -z "$pw" ] ; then 
    echo "password can not be null, reset to default 'windyboy'"
    pw="windyboy"
fi
sed -i "s@windyboy@$pw@" shadowsocks.json
port=8765
read -p "Please input server port:" port
echo "$port" | grep -q "^?[0-9]+$"
if  [ ! $? -eq 0 ] ;then
    echo "server port must be number, reset to default '8765'"
    port=8765
fi
sed -i "s@8765@$port@" shadowsocks.json
echo "get supervisor config..."
wget http://windy.me/sss/shadowsocks.conf
install puppet repo
wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
dpkg -i puppetlabs-release-precise.deb

apt update
apt upgrade -y
apt install puppet

echo "install shadowsocks server software..."
puppet apply shadowsocks.pp

#get public ip address
pia=$(wget -qO- http://ipecho.net/plain)
echo "public ip address:$pia"

echo "shadowsocks client configuration 'config.json':"
cp shadowsocks.json config.json
sed -i "s@0.0.0.0@$pia@g" config.json
cat config.json

cd .. 
rm -rf sss
echo "Installation is done!"
