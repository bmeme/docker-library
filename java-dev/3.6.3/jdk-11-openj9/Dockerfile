FROM maven:3.6.3-jdk-11-openj9
LABEL maintainer="Michele Mondelli <michele.mondelli@bmeme.com>"

RUN apt update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

