#!/bin/bash
##http://www.vsyour.com/post/140.html
num=100 #上限
cd /home/wwwlogs
#读取最新1000条记录，如果单IP超过100条就封掉。
for i in tail access.log -n 1000|awk '{print $1}'|sort|uniq -c|sort -rn|awk '{if ($1>$num){print $2}}'
do
      iptables -I INPUT -p tcp -s $i --dport 80 -j DROP
done