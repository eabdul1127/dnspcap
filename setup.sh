#!/bin/bash
echo "exports.secret_key = 'Compassys';" > /etc/dnscap.js
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get update
apt-get install nodejs
chmod /etc/dnspcap.js 0600
apt-get install libpcap-dev git
npm install
mv ./node_modules /usr/sbin/
mv ./dnspcap.js /usr/sbin
/home/ubuntu/dnspcap.js eno1 &
/home/ubuntu/dnspcap.js eno2 &
/home/ubuntu/dnspcap.js eno3 &