# Mpush - Dockerfile

[Mpush](http://mpusher.github.io)
## System introduction.
Mpush, an open source real-time message push system, is developed with the Java language and the server adopts the modular design. It has the characteristics of simple protocol, safe transmission, smooth interface, real-time efficiency, strong scalability, configurable, convenient deployment and perfect monitoring. It is also a rare commercial open source push system.

-------

## Features and advantages
1. Open source code, including server, android, ios (unlike some open source services open only part of the code, contempt under)
2. High code quality, fully modular design, true commercial grade product, considering most of the scenarios encountered in push
3. High security, based on RSA compact encryption handshake protocol, simple, efficient, secure
4. Support broken line reconnection and fast reconnection under weak network, automatic sleep without network to save power and resources
5. Compact protocol, smooth interface, data compression support, more save traffic
6. Support for cluster deployment, load balancing, based on a mature zookeeper implementation
7. User routing using redis cluster, support single write, double write, cluster grouping; Good performance and high availability
8. Support for HTTP proxies, where a single TCP link takes over most of the application requests, making HTTP requests more timely
9. Highly configurable, most scenarios can be met by modifying the configuration
10. Expandable, highly modular, SPI mode - based pluggable design to meet special needs
11. Perfect monitoring, detailed log, can quickly troubleshoot online problems and service tuning

-------

## Docker
 
SSH <br>
user：root <br>
password：password <br>

-------

* [x] Mpush - 0.8.0 <br>
* [x] Mpush - Alloc - 0.8.0 <br>
* [x] Zookeeper - 3.3.6 <br>
-------

```
FROM centos:6.7
MAINTAINER xubowen "xbw@ecfun.cc"

RUN yum update -y glibc-common

RUN rpm --rebuilddb && yum install -y sudo passwd openssh-server openssh-clients tar screen crontabs strace telnet perl libpcap bc patch ntp dnsmasq unzip pax which

RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

RUN (rpm --rebuilddb && yum install -y hiera lsyncd sshpass rng-tools)

RUN (rpm --rebuilddb && yum -y install java-1.8.0-openjdk.x86_64)

RUN (rpm --rebuilddb && yum -y install redis)

RUN (service sshd start; \
	 sed -i 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config; \
	 sed -i 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config; \
	 sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config; \
	 sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/CentOS-Base.repo)

RUN (mkdir -p /root/.ssh/; \
	 rm -f /var/lib/rpm/.rpm.lock; \
	 echo "StrictHostKeyChecking=no" > /root/.ssh/config; \
	 echo "UserKnownHostsFile=/dev/null" >> /root/.ssh/config)

RUN echo "root:password" | chpasswd

ADD mpush.tar /root/
ADD redis.conf /etc/redis.conf
COPY start.sh /root/start.sh
RUN chmod +x /root/start.sh
EXPOSE 9999
EXPOSE 22
CMD /root/start.sh

```

-------

## Donate
![](https://github.com/xbw12138/dockerfile_mpush/blob/master/alipay.png)
