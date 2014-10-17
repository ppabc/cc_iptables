#!/bin/bash
modprobe ip_tables
modprobe iptable_nat
modprobe ip_nat_ftp
modprobe ip_conntrack
modprobe ip_conntrack_ftp

ipt=/sbin/iptables

lan=10.0.0.0/255.255.255.0
lo=127.0.0.1

$ipt -F
$ipt -t nat  -F
$ipt -X
$ipt -Z

$ipt -A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT
$ipt -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
$ipt -A OUTPUT -j ACCEPT
$ipt -A INPUT -s $lo -j ACCEPT
$ipt -A INPUT -s $lan -j ACCEPT
$ipt -A INPUT -s 111.11.11.11 -j ACCEPT
$ipt -A INPUT  -p udp --sport 53  -j ACCEPT
$ipt -A INPUT  -p udp --sport 123  -j ACCEPT
$ipt -A INPUT  -p tcp --dport 25  -j ACCEPT
$ipt -A INPUT  -p tcp --dport 80  -j ACCEPT
$ipt -A INPUT  -p tcp --dport 22  -j ACCEPT
$ipt -A INPUT  -p tcp --dport 3306  -j ACCEPT
$ipt -A INPUT  -p tcp --dport 9988  -j ACCEPT
$ipt -A INPUT -j REJECT
$ipt -A FORWARD -j REJECT
$ipt -I INPUT -s 123.45.6.7 -j DROP


####NAT
#echo '1' > /proc/sys/net/ipv4/ip_forward
#$ipt  -t nat -A POSTROUTING -s 10.0.0.6  -j SNAT --to-source 198.7.56.11
#$ipt  -t nat -A POSTROUTING -s 10.0.0.7  -j SNAT --to-source 198.7.56.11

/sbin/service iptables save
echo ok
