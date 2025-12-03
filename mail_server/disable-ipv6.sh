#!/bin/bash

echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf

sysctl -p

ip a | grep inet6 && echo "ipv6 disabled"
