#!/usr/bin/env bash

#$1=service name;

if [[ $1 = "" ]];then
	echo "error:service name is null." && exit
else
	sed -i /#$1_begin#/,/#$1_end#/d haproxy.cfg && sed -i /$1/d haproxy.cfg
fi
