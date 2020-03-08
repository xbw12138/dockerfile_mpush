#/bin/bash
/zookeeper/bin/zkServer.sh start
sed -i "s/REDIS_ADDR/${REDIS_ADDR}/g" /mpush/conf/mpush.conf
sed -i "s/REDIS_PASS/${REDIS_PASS}/g" /mpush/conf/mpush.conf
sed -i "s/HOST_IP/${HOST_IP}/g" /mpush/conf/mpush.conf

sed -i "s/REDIS_ADDR/${REDIS_ADDR}/g" /alloc/conf/mpush.conf
sed -i "s/REDIS_PASS/${REDIS_PASS}/g" /alloc/conf/mpush.conf

/mpush/bin/mp.sh  start
/alloc/bin/mp.sh  start
tail -f /mpush/logs/mpush.out



