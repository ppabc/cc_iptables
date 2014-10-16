#!/bin/bash
##http://yzs.me/2050.html
#函数ban_now
ban_now() {
#输出IP的内容
echo $1
#执行iptables对该IP封禁
iptables -I INPUT -s $1 -p all -j DROP
#封禁后执行mail命令，给指定邮箱发一封邮件
echo -e "IP:$1 was banned at $(date).\n\niptables filter tables:\n\n$(iptables -L -n -t filter)" | mail -s "IP:$1 was banned at $(date)" your@email.com
}
#循环的开始
while [ "$loop" = "" ]
do
#清空日志文件
cat>/var/log/nginx/iponly.log<<EOF
EOF
#延迟五秒
ping -c 5 127.0.0.1 >/dev/null 2>&1
#合并，排序IP，输出获取请求数最大的IP及其请求数，请求数与IP之间使用英文逗号隔开，然后赋值给connections
connections=$(cat /var/log/nginx/iponly.log | sort -n | uniq -c | sort -nr | awk '{print $1 "," $2}')
#判断变量connections是否为空
if [ "$connections" != "" ];then
#输出变量connections的内容
  echo $connections
#连接数的for循环开始
  for ipconntctions in $connections
    do
#截取连接数
      connectnumber=$(echo $ipconntctions | cut -d "," -f 1)
#判断该IP连接数是否大于200
      test $connectnumber -ge 200 && banit=1
#大于200，把IP赋值给变量fuckingip
      if [ "$banit" = "1" ];then
          fuckingip=$(echo $ipconntctions | cut -d "," -f 2)
          ban_now $fuckingip
          unset banit
      else
#否则，结束for循环
          break
      fi
     done
fi
done