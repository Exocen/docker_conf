#!/bin/bash

if ip a | grep inet6; then

    echo "Ipv6 detected, disabling"

    echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
    echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
    echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf

    sysctl -p

fi

ip a | grep inet6 && echo "ipv6 still active !" || echo "ipv6 disabled"
