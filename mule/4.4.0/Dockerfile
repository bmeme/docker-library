FROM eclipse-temurin:11-jre-jammy

ENV MULE_HOME=/opt/mule
ENV MULE_VERSION=4.4.0
ENV MULE_MD5=84f9f9bd23c71b248f295d894e41fb01
ENV TZ=Europe/Rome

RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN adduser --group mule
RUN adduser --disabled-login --ingroup mule mule

RUN mkdir /opt/mule-standalone-${MULE_VERSION} && \
    ln -s /opt/mule-standalone-${MULE_VERSION} ${MULE_HOME} && \
    chown mule:mule -R /opt/mule*

RUN echo ${TZ} > /etc/timezone

USER mule

RUN cd ~ && wget -nv https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/${MULE_VERSION}/mule-standalone-${MULE_VERSION}.tar.gz && \
    echo "${MULE_MD5}  mule-standalone-${MULE_VERSION}.tar.gz" | md5sum -c && \
    cd /opt && \
    tar xzf ~/mule-standalone-${MULE_VERSION}.tar.gz && \
    rm ~/mule-standalone-${MULE_VERSION}.tar.gz

# Define mount points.
VOLUME ["${MULE_HOME}/logs", "${MULE_HOME}/conf", "${MULE_HOME}/apps", "${MULE_HOME}/domains"]

# Define working directory.
WORKDIR ${MULE_HOME}

CMD [ "/opt/mule/bin/mule"]

# Default http port
EXPOSE 8081