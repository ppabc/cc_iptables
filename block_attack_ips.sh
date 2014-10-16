#!/bin/bash
# http://www.111cn.net/sys/linux/61035.htm

logfile=/webserver/blog/logs/rainbow_access.log
function check_root(){
  if [ $EUID -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
  fi
}
function block_ips(){
  blacklist=$@
  if [ ! -z "${blacklist}" ]; then
    for ip in ${blacklist}
    do
      if ! $(/sbin/iptables-save | grep -wq ${ip}); then
        echo /sbin/iptables -I INPUT -s ${ip}/32 -p tcp -m tcp --dport 80 -j DROP
        /sbin/iptables -I INPUT -s ${ip}/32 -p tcp -m tcp --dport 80 -j DROP
      fi
    done
  fi
}
function check_login(){
  tailnum=10000
  page=wp-login.php
  retry=5
  
  command="grep -w POST ${logfile} |tail -n ${tailnum} |grep -w ${page} |awk '{print $1}' |sort |uniq -c |awk '($1 > ${retry}){print $2}'"
  blacklist=$(eval ${command})
  block_ips ${blacklist}
}
function check_others(){
  tailnum=10000
  retry=400
  
  command="tail -n ${tailnum} ${logfile} |awk '{print $1}' |sort |uniq -c |awk '($1 > ${retry}){print $2}'"
  blacklist=$(eval ${command})
  block_ips ${blacklist}
}
check_root
check_login
check_others