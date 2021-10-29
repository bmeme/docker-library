ARG MAVEN_VERSION
ARG JDK_VARIANT
FROM maven:${MAVEN_VERSION}-${JDK_VARIANT}

RUN apt-get update && \
    apt-get install -y git unzip zip && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG MN_VERSION

RUN cd /opt && \
    curl -L https://github.com/micronaut-projects/micronaut-starter/releases/download/v${MN_VERSION}/micronaut-cli-${MN_VERSION}.zip --output micronaut-cli-${MN_VERSION}.zip && \
    unzip micronaut-cli-${MN_VERSION}.zip && \
    rm micronaut-cli-${MN_VERSION}.zip && \
    mv micronaut-cli-${MN_VERSION} micronaut

ENV PATH="/opt/micronaut/bin:${PATH}"

ARG BUILD_DATE

LABEL maintainer="Michele Mondelli <michele.mondelli@bmeme.com>" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="bmeme/mn-dev" \
      org.label-schema.version="${MN_VERSION}-${JDK_VARIANT}" \
      org.label-schema.description="Micronaut framework development image" \
      org.label-schema.url="https://www.bmeme.com/"