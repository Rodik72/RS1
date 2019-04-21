#!/bin/bash

# Flushing all rules

/usr/sbin/iptables -F
/usr/sbin/iptables -X

#Set Policy 

iptables -P INPUT DROP

iptables -A INPUT -p tcp --dport 72 -j ACCEPT

#Protection against SYN-Flood

iptables -A INPUT -p tcp --dport 72 --syn -m limit --limit 2/s --limit-burst 30 -j ACCEPT

#Protection against Pingflood

iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 1/s -j ACCEPT

#Protection against Port Scan

iptables -A INPUT -p tcp --dport 72 --tcp-flags ALL NONE -m limit --limit 1/h -j ACCEPT
iptables -A INPUT -p tcp --dport 72 --tcp-flags ALL ALL -m limit --limit 1/h -j ACCEPT
