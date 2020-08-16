FROM adoptopenjdk:11-jre-hotspot-bionic
MAINTAINER Daniele Piaggesi <daniele.piaggesi@bmeme.com>
ENV REFRESHED_AT 2020-08-07

# Define environment variables.
ENV BUILD_DATE=07082020
ENV MULE_HOME=/opt/mule
ENV MULE_VERSION=4.2.1
ENV MULE_MD5=de730172857f8030746c40d28e178446
ENV TINI_SUBREAPER=
ENV TZ=Europe/Rome

RUN apt update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN adduser --group mule
RUN adduser --disabled-login --ingroup mule mule

RUN mkdir /opt/mule-standalone-${MULE_VERSION} && \
    ln -s /opt/mule-standalone-${MULE_VERSION} ${MULE_HOME} && \
    chown mule:mule -R /opt/mule*

RUN echo ${TZ} > /etc/timezone

USER mule

RUN cd ~ && wget https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/${MULE_VERSION}/mule-standalone-${MULE_VERSION}.tar.gz && \
    echo "${MULE_MD5}  mule-standalone-${MULE_VERSION}.tar.gz" | md5sum -c && \
    cd /opt && \
    tar xvzf ~/mule-standalone-${MULE_VERSION}.tar.gz && \
    rm ~/mule-standalone-${MULE_VERSION}.tar.gz

# Define mount points.
VOLUME ["${MULE_HOME}/logs", "${MULE_HOME}/conf", "${MULE_HOME}/apps", "${MULE_HOME}/domains"]

# Define working directory.
WORKDIR ${MULE_HOME}

CMD [ "/opt/mule/bin/mule"]

# Default http port
EXPOSE 8081