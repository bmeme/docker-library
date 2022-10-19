ARG JRE_VERSION
FROM eclipse-temurin:${JRE_VERSION}

ARG JRE_VERSION
ENV MULE_HOME=/opt/mule
ENV MULE_VERSION=4.4.0-20220919
ENV MULE_MD5=e66433c4f9887ce0e9f91e467fe4d0f3
ENV TZ=Europe/Rome

RUN adduser --group mule
RUN adduser --disabled-login --ingroup mule mule

RUN mkdir /opt/mule-standalone-${MULE_VERSION} && \
    ln -s /opt/mule-standalone-${MULE_VERSION} ${MULE_HOME} && \
    chown mule:mule -R /opt/mule* && \
    echo "MULE_VERSION=${MULE_VERSION}\nMULE_MD5=${MULE_MD5}\nJRE_IMAGE=eclipse-temurin\nJRE_VERSION=${JRE_VERSION}" > /opt/README

RUN echo ${TZ} > /etc/timezone

USER mule

RUN cd ~ && wget -nv https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/${MULE_VERSION}/mule-standalone-${MULE_VERSION}.tar.gz && \
    echo "${MULE_MD5} mule-standalone-${MULE_VERSION}.tar.gz" | md5sum -c && \
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