#!/bin/bash

cd /tmp

if [ -f "/tmp/installss.sh" ]
then
    rm /tmp/installss.sh
fi
wget http://windy.me/sss/installss.sh

echo "execute the command below\nsh /tmp/installss.sh"

