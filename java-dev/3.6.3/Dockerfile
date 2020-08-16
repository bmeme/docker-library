FROM maven:3.6.3-jdk-11-openj9
MAINTAINER Daniele Piaggesi <daniele.piaggesi@bmeme.com>
ENV REFRESHED_AT 2020-08-07

RUN apt update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

