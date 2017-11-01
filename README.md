# dnspcap

dnspcap.js: Primary script handling the raw traffic coming from the university network interfaces, sanitizing it, and sending it over to a less priveledged part of the machine via ZeroMQ for more filtering.(see dnscap https://github.com/eabdul1127/dnscap)

setup.sh: shell script responsible for initializing the machine and installing necessary packages. 

Very little should need to be changed here, and doing so would require the assistance of a faculty member.

