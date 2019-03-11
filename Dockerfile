FROM openjdk:11
MAINTAINER brade
LABEL Discription="mpush" version="0.9.1"
COPY mpush/ /usr/local/mpush/
RUN chmod u+x /usr/local/mpush/bin/*.sh
WORKDIR /usr/local/mpush/bin
EXPOSE 3000
CMD ["./mp.sh","start-foreground"]