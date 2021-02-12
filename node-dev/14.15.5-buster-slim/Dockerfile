FROM node:14.15.5-buster-slim
LABEL maintainer="michele.mondelli@bmeme.com"

ARG BUILD_DATE

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="bmeme/node-dev" \
      org.label-schema.version="14.15.5-buster-slim" \
      org.label-schema.description="NodeJS development image" \
      org.label-schema.url="https://www.bmeme.com/"

RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
