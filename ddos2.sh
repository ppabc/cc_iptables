#!/bin/sh
##http://www.oschina.net/code/snippet_17_9265
############### KILL DDOS ##############
iptables_log="/data/logs/iptables_conf.log"
### Iptables 配置导出的路径，可任意修改 ###
########################################
status=`netstat -na|awk '$5 ~ /[0-9]+:[0-9]+/ {print $5}'|awk -F ":" -- '{print $1}' |sort -n|uniq -c |sort -n|tail -n 1|grep -v 127.0.0.1`
NUM=`echo $status|awk '{print $1}'`
IP=`echo $status|awk '{print $2}'`
result=`echo "$NUM > 200" | bc`
### 如果同时连接数大于 200 则干掉！###
if [ $result = 1 ]
then
echo IP:$IP is over $NUM, BAN IT!
/sbin/iptables -I INPUT -s $IP -j DROP
fi
########################################
iptables-save > ${iptables_log}
### 输出当前的 iptable 配置作为日志 ###
########################################