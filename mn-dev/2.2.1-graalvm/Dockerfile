FROM debian:stable-slim
LABEL maintainer="Michele Mondelli <michele.mondelli@bmeme.com>"

ENV GRAALVM_VERSION 20.3.0
ENV MAVEN_VERSION 3.6.3
ENV MN_VERSION 2.2.1

RUN apt-get update && \
    apt-get install -y git unzip zip curl build-essential zlib1g-dev && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd /opt && \
    curl -L https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-java11-linux-amd64-${GRAALVM_VERSION}.tar.gz \
      --output graalvm-ce-java11-linux-amd64-${GRAALVM_VERSION}.tar.gz && \
    tar xf graalvm-ce-java11-linux-amd64-${GRAALVM_VERSION}.tar.gz && \
    mv graalvm-ce-java11-${GRAALVM_VERSION} /opt/graalvm && \
    rm -f graalvm-ce-java11-linux-amd64-${GRAALVM_VERSION}.tar.gz

RUN cd /opt && \
    curl -L https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
      --output apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar xf apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    mv apache-maven-${MAVEN_VERSION} /opt/maven && \
    rm -f apache-maven-${MAVEN_VERSION}-bin.tar.gz

RUN cd /opt && \
    curl -L https://github.com/micronaut-projects/micronaut-starter/releases/download/v${MN_VERSION}/micronaut-cli-${MN_VERSION}.zip --output micronaut-cli-${MN_VERSION}.zip && \
    unzip micronaut-cli-${MN_VERSION}.zip && \
    rm micronaut-cli-${MN_VERSION}.zip && \
    mv micronaut-cli-${MN_VERSION} micronaut

ENV PATH="${PATH}:/opt/graalvm/bin:/opt/maven/bin:/opt/micronaut/bin"
ENV JAVA_HOME="/opt/graalvm"

RUN gu install native-image
