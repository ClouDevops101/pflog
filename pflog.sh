#! /bin/bash
# bodged solution to absence of pflogd, ref 'Book of PF' p136
curl  http://ipdeny.com/ipblocks/data/countries/fr.zone > /etc/pf-files/FR_blocked_zone
curl  http://ipdeny.com/ipblocks/data/countries/gf.zone >> /etc/pf-files/FR_blocked_zone
curl  http://ipdeny.com/ipblocks/data/countries/pf.zone >> /etc/pf-files/FR_blocked_zone

curl  http://www.ipdeny.com/ipv6/ipaddresses/blocks/fr.zone  > /etc/pf-files/FR_ipv6_blocked_zone
curl  http://www.ipdeny.com/ipv6/ipaddresses/blocks/gf.zone  >> /etc/pf-files/FR_ipv6_blocked_zone
curl  http://www.ipdeny.com/ipv6/ipaddresses/blocks/pf.zone  >> /etc/pf-files/FR_ipv6_blocked_zone

echo '!your_public_ip' >> /etc/pf-files/FR_blocked_zone

curl http://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt > /etc/pf-files/Emerging-Block-IP


pfctl -ef /etc/pf.conf
ifconfig pflog0 create
/usr/sbin/tcpdump -lnettti pflog0 | /usr/bin/logger -t pf -p local2.info
