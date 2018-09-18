FROM maven:3-jdk-8-alpine AS build
MAINTAINER Daniele Piaggesi <daniele.piaggesi@bmeme.com>

ARG NEXUS_VERSION=3.13.0
ARG NEXUS_BUILD=01
ARG NEXUS_HELM_VERSION=0.0.2

ADD https://github.com/sonatype-nexus-community/nexus-repository-helm/archive/v${NEXUS_HELM_VERSION}.tar.gz /opt/
RUN tar -xvzf /opt/v${NEXUS_HELM_VERSION}.tar.gz -C /opt && \
    cd /opt/nexus-repository-helm-${NEXUS_HELM_VERSION} && \
    sed -i "s/3.13.0-01/${NEXUS_VERSION}-${NEXUS_BUILD}/g" pom.xml && \
    mvn clean package

FROM quay.io/travelaudience/docker-nexus:3.13.0
ENV NEXUS_VERSION "3.13.0"
ENV NEXUS_BUILD "01"
ENV NEXUS_HELM_VERSION "0.0.2"

ARG TARGET_DIR=/opt/sonatype/nexus/system/org/sonatype/nexus/plugins/nexus-repository-helm/${NEXUS_HELM_VERSION}/

RUN mkdir -p ${TARGET_DIR} && \
    sed -i 's@nexus-repository-maven</feature>@nexus-repository-maven</feature>\n        <feature prerequisite="false" dependency="false">nexus-repository-helm</feature>@g' /opt/sonatype/nexus/system/org/sonatype/nexus/assemblies/nexus-core-feature/${NEXUS_VERSION}-${NEXUS_BUILD}/nexus-core-feature-${NEXUS_VERSION}-${NEXUS_BUILD}-features.xml && \
    sed -i 's@<feature name="nexus-repository-maven"@<feature name="nexus-repository-helm" description="org.sonatype.nexus.plugins:nexus-repository-helm" version="0.0.2">\n        <details>org.sonatype.nexus.plugins:nexus-repository-helm</details>\n        <bundle>mvn:org.sonatype.nexus.plugins/nexus-repository-helm/0.0.2</bundle>\n        <bundle>mvn:org.apache.commons/commons-compress/1.11</bundle>\n   </feature>\n    <feature name="nexus-repository-maven"@g' /opt/sonatype/nexus/system/org/sonatype/nexus/assemblies/nexus-core-feature/${NEXUS_VERSION}-${NEXUS_BUILD}/nexus-core-feature-${NEXUS_VERSION}-${NEXUS_BUILD}-features.xml

COPY --from=build /opt/nexus-repository-helm-${NEXUS_HELM_VERSION}/target/nexus-repository-helm-${NEXUS_HELM_VERSION}.jar ${TARGET_DIR}

USER nexus
