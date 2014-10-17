#!/bin/bash
#netstat -na|grep ESTABLISHED|awk '{print $5}'|awk -F: '{print $1}'|sort|uniq -c|sort -n |tail -1 |awk 'FS="[ ]+" {print $2}'
netstat -na|grep ESTABLISHED|awk '{print $5}'|awk -F: '{print $1}'|sort|uniq -c|sort -n
echo "ESTABLISHED ok"
netstat -an| grep :80 | grep -v 127.0.0.1 |awk '{ print $5 }' | sort|awk -F: '{print $1,$4}' | uniq -c | awk '$1>2 {print $1,$2}'
echo "80 ok"
