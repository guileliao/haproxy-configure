#!/usr/bin/env bash

#$1=service name;
#$2=node name;
#$3=node ipaddress;
#$4=node port;
#$5=weight value;

if [[ $1 = "" ]];then
	echo "error:service name is null." && exit
fi
if [[ $(grep '^acl' /etc/haproxy/haproxy.cfg|grep ""$1"$") = "" ]];then
	sed -i /^#ACL#/a\ "acl $1_acl path_reg \-i \/$1/" /etc/haproxy/haproxy.cfg
fi
if [[ $(grep "^use_backend" /etc/haproxy/haproxy.cfg|grep ""$1_acl"$") = "" ]];then
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
