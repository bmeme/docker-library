ARG NODE_VERSION
FROM node:${NODE_VERSION}-buster-slim

ARG BUILD_DATE

LABEL maintainer="Michele Mondelli <michele.mondelli@bmeme.com>" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="bmeme/node-dev" \
      org.label-schema.version="${NODE_VERSION}-buster-slim" \
      org.label-schema.description="NodeJS development image" \
      org.label-schema.url="https://www.bmeme.com/"

RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
