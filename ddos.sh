#!/bin/sh
#1
if [ -d '/usr/local/ddos' ]; then
        echo; echo; echo "Please un-install the previous version first"
	echo; 
	echo 'Uninstall:'; 
	echo ;
	echo 'wget http://www.ctohome.com/linux-vps-pack/soft/ddos/uninstall.ddos;sh uninstall.ddos;';
	echo; 
	echo; 
        exit 0
else
        mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.ctohome.com/linux-vps-pack/soft/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.ctohome.com/linux-vps-pack/soft/ddos/ignore.ip.list

/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:" >>  /usr/local/ddos/ignore.ip.list;
chattr +i /usr/local/ddos/ignore.ip.list;

echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.ctohome.com/linux-vps-pack/soft/ddos/ddos-deflate.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'

echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'DOS-Deflate Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'ignore ip is at /usr/local/ddos/ignore.ip.list '
echo 'if you want edit it please use chattr -i /usr/local/ddos/ignore.ip.list first'

service iptables restart

clear

echo 'Script license: /usr/local/ddos/LICENSE';
echo '';
echo '';
echo '';
echo '';
echo '=========================================================';
echo "======  DOS-Deflate Installation has completed     ======";
echo "======                                             ======";
echo "======  http://www.ctohome.com/FuWuQi/df/318.html  ======";
echo "======                                             ======";
echo "======                                             ======";
echo "======                                             ======";
echo "======       How to edit ddos configure file       ======";
echo "======                                             ======";
echo "====== http://www.ctohome.com/FuWuQi/df/318.html   ======";
echo "======                                             ======";
echo "======                                             ======";
echo "======         How to edit ignore IP list          ======";
echo "======                                             ======";
echo "====== http://www.ctohome.com/FuWuQi/df/318.html   ======";
echo "======                                             ======";
echo "======                                             ======";
echo "======       Block IP more than 50 connections     ======";
echo "======                                             ======";
echo "======        /usr/local/ddos/ddos.sh -k 50        ======";
echo "======                                             ======";
echo "======                                             ======";
echo "======                                             ======";
echo "======           *  List blocked IPs *             ======";
echo "======                                             ======";
echo "======                 iptables -L                 ======";
echo "======                                             ======";
echo "======                                             ======";
echo '=========================================================';
echo '';
echo '';
echo '******** Check ip connections now: ********';
echo '';
echo "netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n";
echo '';
echo '';