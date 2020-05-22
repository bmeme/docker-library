FROM node:8.16.2-slim
LABEL   com.bmeme.maintainer.name="Daniele Piaggesi" \
        com.bmeme.maintainer.email="daniele.piaggesi@bmeme.com" \
        com.bmeme.project="Angular-dev" \
        com.bmeme.vendor="Bmeme" \
        com.bmeme.refreshedat="2020-05-20"

ENV NG_CLI_VERSION=1.7.4

RUN set -eux; \
    apt-get update; \
    apt-get install -y apt-transport-https; \
    \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -; \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list; \
    curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -; \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list; \
    \
    apt-get update; \
    apt-get install -y xvfb google-chrome-stable yarn; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD config/xvfb.sh /etc/init.d/xvfb
ADD scripts/entrypoint.sh /entrypoint.sh

ENV DISPLAY :99.0
ENV CHROME_BIN /usr/bin/google-chrome

RUN chmod +x /etc/init.d/xvfb; \
    chmod +x /entrypoint.sh; \
    \
    yarn global add @angular/cli@$NG_CLI_VERSION && rm -rf $(yarn cache dir)

ENTRYPOINT ["/entrypoint.sh"]