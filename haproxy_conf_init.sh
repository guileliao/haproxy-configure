#!/usr/bin/env bash

if [[ $(rpm -qa|grep haproxy) = "" ]];then
        echo ""haproxy" has been not installed." && exit
else
        cp -a /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.old && \
cat>/etc/haproxy/haproxy.cfg<<EOF
#----------------
# Global settings
#----------------
global
    log         127.0.0.1 local2
    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     4000
    user        haproxy
    group       haproxy
    daemon
    stats socket /var/lib/haproxy/stats
defaults
    mode                    http
    log                     global
    option                  httplog
    option                  dontlognull
    option http-server-close
    option forwardfor       except 127.0.0.0/8
    option                  redispatch
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 500
#--------------------
#Application frontend
#--------------------
frontend        GEOGLOBE
bind    *:8080
#ACL#
#USE_BACKEND#
EOF
fi
