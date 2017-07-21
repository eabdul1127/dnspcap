#!/bin/bash
apt-get update
apt-get install software-properties-common
apt-get update
apt-get install ansible
echo "exports.secret_key = 'Compassys';" > /etc/dnspcap_config.js
ansible-playbook ansible.yml
scp usr/sbin/dnspcap/dnspcap.js ..
pm2 startup
pm2 start /usr/sbin/dnspcap.js eno1 &
pm2 start /usr/sbin/dnspcap.js eno2 &
pm2 start /usr/sbin/dnspcap.js eno3 &
pm2 save
