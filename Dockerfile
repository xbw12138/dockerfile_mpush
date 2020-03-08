FROM openjdk:8-jdk

ADD ./mpush /mpush
ADD ./zookeeper /zookeeper
ADD ./alloc /alloc
ADD ./entry-point.sh entry-point.sh
ENTRYPOINT exec sh /entry-point.sh
