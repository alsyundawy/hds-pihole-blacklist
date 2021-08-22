#!/bin/bash
cd /tmp
apt -y -q install dos2unix
rm -rf /tmp/domain.txt
wget -c --no-check-certificate https://trustpositif.kominfo.go.id/assets/db/domains_isp | sed 's/\*.//g' | tr '[:upper:]' '[:lower:]' | sed '/\(\/\|:\|=\|\.\.\|\.$\|[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}\($\|\s\)\|^$\|\*\)/d' | perl -nle 'print if m{^[[:ascii:]]+$}' > /tmp/domain.txt;
dos2unix /tmp/domain.txt;
cat /tmp/domain.txt | sort | uniq > /tmp/domain.txt.tmp
rm -rf /tmp/domain.txt
mv /tmp/domain.txt.tmp /tmp/domain.txt
echo > /etc/dnsmasq.d/dnssehat.conf;
IP=$(ifconfig | perl -nle 's/dr:(\S+)/print $1/e' | grep -v 127.0.0.1);
for i in $(cat /tmp/domain.txt);
do
echo -e "address=/$i/$IP" >> /etc/dnsmasq.d/dnssehat.conf;
done
pihole restartdns
cd ~
