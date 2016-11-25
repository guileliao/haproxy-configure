#!/usr/bin/env bash

#$1=node name;

if [[ $1 = "" ]];then
	echo "error:node name is null." && exit
fi
sed -i /"$1"/d /etc/haproxy/haproxy.cfg
