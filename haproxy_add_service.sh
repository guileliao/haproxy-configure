#!/usr/bin/env bash

#$1=service name;
#$2=proxyurl value

if [ -z "$1" ];then
	echo "error:service name is null." && exit 2
fi

if [ -z "$2" ] && [ -z "$(grep '^acl' /etc/haproxy/haproxy.cfg|grep ""$1"$")" ];then
	sed -i /^#ACL#/a\ "acl $1_acl path_reg \-i \/$1/" /etc/haproxy/haproxy.cfg
fi

if [ -n "$2" ] && [ -z "$(grep '^acl' /etc/haproxy/haproxy.cfg|grep ""$1"$")" ];then
	sed -i /^#ACL#/a\ "acl $1_acl path_reg \-i \/$2/$1/" /etc/haproxy/haproxy.cfg
fi

if [ -z "$(grep "^use_backend" /etc/haproxy/haproxy.cfg|grep ""$1_acl"$")" ];then
	sed -i /^#USE_BACKEND#/a\ "use_backend $1_backend \if $1_acl" /etc/haproxy/haproxy.cfg
fi

sed -i /#$1_begin#/,/#$1_end#/d /etc/haproxy/haproxy.cfg

cat>>/etc/haproxy/haproxy.cfg<<EOF
#$1_begin#	
backend $1_backend
balance roundrobin
mode http
#$1_end#
EOF
