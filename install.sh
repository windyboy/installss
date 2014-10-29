#!/bin/bash

cd /tmp

if [ ! -f "/tmp/installss.sh" ]
then
    wget http://windy.me/sss/installss.sh
fi

sh /tmp/installss.sh
