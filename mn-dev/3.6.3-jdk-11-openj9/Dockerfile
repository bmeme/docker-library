FROM maven:3.6.3-jdk-11-openj9

RUN apt-get update && \
    apt-get install -y git unzip zip && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG MN_VERSION
ARG BUILD_DATE

LABEL maintainer="Michele Mondelli <michele.mondelli@bmeme.com>" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="bmeme/mn-dev" \
      org.label-schema.version="${MN_VERSION}-jdk-11-openj9" \
      org.label-schema.description="Micronaut framework development image" \
      org.label-schema.url="https://www.bmeme.com/"

RUN cd /opt && \
    curl -L https://github.com/micronaut-projects/micronaut-starter/releases/download/v${MN_VERSION}/micronaut-cli-${MN_VERSION}.zip --output micronaut-cli-${MN_VERSION}.zip && \
    unzip micronaut-cli-${MN_VERSION}.zip && \
    rm micronaut-cli-${MN_VERSION}.zip && \
    mv micronaut-cli-${MN_VERSION} micronaut

ENV PATH="/opt/micronaut/bin:${PATH}"
