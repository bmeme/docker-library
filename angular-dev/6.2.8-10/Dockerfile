FROM node:10.20.0-stretch-slim
MAINTAINER Daniele Piaggesi <daniele.piaggesi@bmeme.com>
ENV REFRESHED_AT 2020-04-09

ENV NG_CLI_VERSION=6.2.8
RUN npm install -g @angular/cli@$NG_CLI_VERSION

RUN mkdir /.npm && chmod 777 /.npm

ADD scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
