ARG MAVEN_VERSION
ARG JDK_VARIANT
FROM maven:${MAVEN_VERSION}-${JDK_VARIANT}
LABEL maintainer="Michele Mondelli <michele.mondelli@bmeme.com>"

RUN apt-get update && \
    apt-get install --no-install-recommends -y git && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG BUILD_DATE

LABEL maintainer="Michele Mondelli <michele.mondelli@bmeme.com>" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="bmeme/java-dev" \
      org.label-schema.version="${MAVEN_VERSION}-${JDK_VARIANT}" \
      org.label-schema.description="Java Maven development image" \
      org.label-schema.url="https://www.bmeme.com/"
