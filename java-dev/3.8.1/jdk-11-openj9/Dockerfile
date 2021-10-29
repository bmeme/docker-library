FROM maven:3.8.1-jdk-11-openj9
LABEL maintainer="Michele Mondelli <michele.mondelli@bmeme.com>"

RUN apt-get update && \
    apt-get install --no-install-recommends -y git && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

