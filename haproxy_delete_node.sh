#!/usr/bin/env bash

#$1=service name;
#$2=node name;
#$3=node ipaddress;
#$4=node port;
#$5=weight value;

if [[ $2 = "" ]];then
	echo "error:node name is null." && exit
fi
sed -i /"$2"/d haproxy.cfg
