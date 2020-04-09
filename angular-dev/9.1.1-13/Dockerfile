FROM node:13.12.0-slim
MAINTAINER Daniele Piaggesi <daniele.piaggesi@bmeme.com>
ENV REFRESHED_AT 2020-04-09

ENV NG_CLI_VERSION=9.1.1

RUN npm install -g @angular/cli@$NG_CLI_VERSION

ADD scripts/entrypoint-chrome.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
