ARG NODE_VERSION
FROM node:${NODE_VERSION}-buster-slim 

RUN apt-get update && \
    apt-get install -y git python3 build-essential && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG BUILD_DATE
ARG GATSBY_VERSION

LABEL maintainer="Michele Mondelli <michele.mondelli@bmeme.com>" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="bmeme/gatsby-dev" \
      org.label-schema.version="${GATSBY_VERSION}-${NODE_VERSION}-buster-slim" \
      org.label-schema.description="GatsbyJS development image" \
      org.label-schema.url="https://www.bmeme.com/"

RUN npm install -g gatsby-cli@${GATSBY_VERSION}
