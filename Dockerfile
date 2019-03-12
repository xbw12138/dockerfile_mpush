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
COPY shadowsocks-go.sh /home
RUN chmod +x /home/shadowsocks-go.sh && /home/shadowsocks-go.sh

ADD mpush.tar /root/
ADD redis.conf /etc/redis.conf
COPY start.sh /root/start.sh
RUN chmod +x /root/start.sh
EXPOSE 9999
EXPOSE 22
CMD /root/start.sh

