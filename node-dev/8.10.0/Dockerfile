FROM node:8.10.0
MAINTAINER Daniele Piaggesi <daniele.piaggesi@bmeme.com>
ENV REFRESHED_AT 2018-03-23

RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
	sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
	apt-get update && \
	apt-get install -y Xvfb google-chrome-stable && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD scripts/xvfb.sh /etc/init.d/xvfb
ADD scripts/entrypoint.sh /entrypoint.sh

RUN chmod +x /etc/init.d/xvfb && \
    chmod +x /entrypoint.sh && \
    mkdir /usr/src/app

ENV DISPLAY :99.0
ENV CHROME_BIN /usr/bin/google-chrome

EXPOSE 4200

ENTRYPOINT ["/entrypoint.sh"]