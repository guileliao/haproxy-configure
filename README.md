# haproxy-configure
haproxy配置工具

* haproxy_conf_init.sh<br>
用途：初始化haproxy配置文件<br>
参数数量：0<br>
参数内容：<br>
传参格式：command<br>
用例：[root@haproxy ~]# **haproxy_conf_init.sh**

* haproxy_add_service.sh<br>
用途：添加服务<br>
参数数量：1<br>
参数内容：服务名称<br>
传参格式：command $1<br>
用例：[root@haproxy ~]# **haproxy_add_service.sh** *server01*

* haproxy_delete_service.sh<br>
用途：删除服务<br>
参数数量：1<br>
参数内容：服务名称<br>
传参格式：command $1<br>
用例：
[root@hproxy ~]# **haproxy_delete_service.sh** *server01*

* haproxy_add_node.sh<br>
用途：添加节点<br>
参数数量：5<br>
参数内容：$1=服务名称；$2=节点名称；$3=节点ip地址；$4=节点对外暴露端口；$5=服务权重值；<br>
传参格式：command $1 $2 $3 $4 $5<br>
用例：[root@haproxy ~]# **haproxy_add_node.sh** *server01 server01_01 192.168.0.1 20001 2*

* haproxy_delete_node.sh<br>
用途：删除节点<br>
参数数量：5<br>
参数内容：$1=服务名称；$2=节点名称；$3=节点ip地址；$4=节点对外暴露端口；$5=服务权重值；<br>
传参格式：command $1<br>
用例：[root@haproxy ~]# **haproxy_delete_node.sh** *server01_01*
