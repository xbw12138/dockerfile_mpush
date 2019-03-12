#!/usr/bin/env bash
#
# Auth:XBW
# Email:xbw@ecfun.cc
# QQ:1076351865
#
#

redis-server /etc/redis.conf
/root/mpush/zookeeper/bin/zkServer.sh start
chmod +x /root/mpush/mpush/bin/*.sh
/root/mpush/mpush/bin/mp.sh start
chmod +x /root/mpush/alloc/bin/*.sh
/root/mpush/alloc/bin/mp.sh start


echo "棒棒 xbw@ecfun.cc 新浪微博 @偏不写作业"
echo "mpush地址 ip:9999的容器端口"