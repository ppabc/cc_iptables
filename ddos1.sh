#!/bin/bash 
##http://blog.liuts.com/post/101/#topreply
/bin/netstat -na|grep ESTABLISHED|awk ¡®{print $5}¡¯|awk -F: ¡®{print $1}¡¯|sort|uniq -c|sort -rn|head -10|grep -v -E ¡¯192.168|127.0¡ä|awk ¡®{if ($2!=null && $1>4) {print $2}}¡¯>/tmp/dropip 

for i in $(cat /tmp/dropip) 
do         
    /sbin/iptables -A INPUT -s $i -j DROP         
    echo "$i kill at `date`">>/var/log/ddos 
done 