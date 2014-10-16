#!/bin/bash
##email: ppabc#qq.com
##ppabc
tail www.aqzt.com.access.log  -n 9999 |awk '{print $1}'|sort|uniq -c|sort -rn|awk '{if ($1>200){print $2}}'  > /data/nginxlogs/block_attack_ips.log

/sbin/iptables -nL |grep DROP | awk '{print $4}' > /data/nginxlogs/iptables.log

filename=`cat /data/nginxlogs/block_attack_ips.log`
for ip in $filename
do
if [ `grep $ip /data/nginxlogs/iptables.log` ]
then
    echo "Already exists"
else
    echo "add"
      /sbin/iptables -I INPUT -p tcp -s $ip --dport 80 -j DROP
fi
 
done