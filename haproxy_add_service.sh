#!/usr/bin/env bash

#$1=service name;
#$2=node name;
#$3=node ipaddress;
#$4=node port;
#$5=weight value;

if [[ $1 = "" ]];then
	echo "error:service name is null." && exit
fi
if [[ $(grep '^acl' haproxy.cfg|grep ""$1"$") = "" ]];then
	sed -i /^#ACL#/a\ "acl $1_acl path_beg \-i \/$1" haproxy.cfg
fi
if [[ $(grep "^use_backend" haproxy.cfg|grep ""$1_acl"$") = "" ]];then
	sed -i /^#USE_BACKEND#/a\ "use_backend $1_backend \if $1_acl" haproxy.cfg
fi
sed -i /#$1_begin#/,/#$1_end#/d haproxy.cfg
cat>>haproxy.cfg<<EOF
#$1_begin#	
backend $1_backend
mode http
#$1_end#
EOF
