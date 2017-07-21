#!/bin/bash
apt-get update
apt-get install software-properties-common
apt-get update
apt-get install ansible
echo "exports.secret_key = 'Compassys';" > /etc/dnscap.js
ansible-playbook ansible.yml
cd /home/ubuntu/dnspcap
./dnspcap.js eno1
./dnspcap.js eno2
./dnspcap.js eno3
