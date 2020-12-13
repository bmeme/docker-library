FROM maven:3.6.3-jdk-11-openj9
LABEL maintainer="Michele Mondelli <michele.mondelli@bmeme.com>"

ENV MN_VERSION 2.2.1

RUN apt-get update && \
    apt-get install -y git unzip zip && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd /opt && \
    curl -L https://github.com/micronaut-projects/micronaut-starter/releases/download/v${MN_VERSION}/micronaut-cli-${MN_VERSION}.zip --output micronaut-cli-${MN_VERSION}.zip && \
    unzip micronaut-cli-${MN_VERSION}.zip && \
    rm micronaut-cli-${MN_VERSION}.zip && \
    mv micronaut-cli-${MN_VERSION} micronaut

ENV PATH="/opt/micronaut/bin:${PATH}"
