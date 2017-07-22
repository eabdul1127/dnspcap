#!/bin/bash

if [[ $UID != 0 ]]; then
  echo "$0: ERROR: Must run installation as root."
  exit
fi

echo "$0: create secret key config file if it doesn't exist"
CFG=/etc/dnspcap.js
if [[ ! -e $CFG ]]; then
  echo "exports.secret_key = 'CHANGE ME';" > $CFG
  chmod 0600 $CFG
fi

echo "$0: install nodejs and supporting Ubuntu packages"
echo 'deb https://deb.nodesource.com/node_6.x trusty main' > /etc/apt/sources.list.d/nodesource.list
echo 'deb-src https://deb.nodesource.com/node_6.x trusty main' >> /etc/apt/sources.list.d/nodesource.list
apt-get update
apt-get install nodejs libpcap-dev build-essential -y

echo "$0: install required nodejs packages"
npm install -g
npm install pm2 -g

echo "$0: start dnspcap.js on eno# interfaces"
HOME=/root
DIR=`dirname $PWD/$0`
pm2 startup
pm2 start $DIR/dnspcap.js --name eno1 --watch -- eno1
pm2 start $DIR/dnspcap.js --name eno2 --watch -- eno2
pm2 start $DIR/dnspcap.js --name eno3 --watch -- eno3
pm2 save
