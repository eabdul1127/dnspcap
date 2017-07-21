#!/bin/bash
echo "exports.secret_key = 'Compassys';" > /etc/dnscap.js
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get update
apt-get install nodejs
chmod /etc/dnspcap.js 0600
apt-get install libpcap-dev git
npm install
npm install pm2 -g
mv ./node_modules /usr/sbin/
mv ./dnspcap.js /usr/sbin
pm2 startup
pm2 start /usr/sbin/dnspcap.js eno1 &
pm2 start /usr/sbin/dnspcap.js eno2 &
pm2 start /usr/sbin/dnspcap.js eno3 &
pm2 save
