ARG NODE_VERSION
FROM node:${NODE_VERSION}-buster-slim 

ARG BUILD_DATE
ARG GATSBY_VERSION

RUN apt-get update && \
    apt-get install --no-install-recommends -y python3 build-essential && \
    npm install -g gatsby-cli@${GATSBY_VERSION} && \
    apt-get purge -y python3 build-essential && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

LABEL maintainer="Michele Mondelli <michele.mondelli@bmeme.com>" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="bmeme/gatsby-dev" \
      org.label-schema.version="${GATSBY_VERSION}" \
      org.label-schema.description="GatsbyJS development image lite" \
      org.label-schema.url="https://www.bmeme.com/"

