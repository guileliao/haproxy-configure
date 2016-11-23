#!/usr/bin/env bash

#$1=service name;
#$2=node name;
#$3=node ipaddress;
#$4=node port;
#$5=weight value;

if [[ $1 = "" ]];then
	echo "error:service name is null." && exit
fi
if [[ $(grep "^#$1_end#" haproxy.cfg) = "" ]];then
	echo "error:service backend is null." && exit
else
	sed -i /^#$1_end#/i\ "server "$2" "$3":"$4" check weight "$5"" haproxy.cfg
fi
