#!/usr/bin/env bash

#$1=service name;
#$2=node name;
#$3=node ipaddress;
#$4=node port;
#$5=weight value;

if [[ $1 = "" ]];then
	echo "error:service name is null." && exit
fi
if [[ $2 = "" ]];then
	echo "error:node name is null." && exit
fi
if [[ $3 = "" ]];then
	echo "error:node ipaddress is null." && exit
fi
if [[ $4 = "" ]];then
	echo "error:node port is null." && exit
fi
if [[ $5 = "" ]];then
	echo "error:weight value is null." && exit
fi
if [[ $(grep "^#$1_end#" haproxy.cfg) = "" ]];then
	echo "error:service backend is null." && exit
else
	sed -i /^#$1_end#/i\ "server "$2" "$3":"$4" check weight "$5"" /etc/haproxy/haproxy.cfg
fi
