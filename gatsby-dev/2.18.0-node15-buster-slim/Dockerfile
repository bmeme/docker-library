FROM node:15.6.0-buster-slim
LABEL maintainer="michele.mondelli@bonsaimeme.com"

ARG BUILD_DATE
ENV GATSBY_VERSION 2.18.0

LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="bmeme/gatsby-dev"
LABEL org.label-schema.description="GatsbyJS development image"
LABEL org.label-schema.url="https://www.bmeme.com/"

RUN apt-get update && \
    apt-get install -y git python3 build-essential && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN npm install -g gatsby-cli@${GATSBY_VERSION}
