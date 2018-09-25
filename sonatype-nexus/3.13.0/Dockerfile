ARG NEXUS_VERSION=3.13.0

FROM maven:3-jdk-8-alpine AS build
ARG NEXUS_VERSION=3.13.0
ARG NEXUS_BUILD=01
ARG HELM_VERSION=0.0.4
ARG GCBLOBSTORE_VERSION=0.2.0

ADD https://github.com/sonatype-nexus-community/nexus-repository-helm/archive/v${HELM_VERSION}.tar.gz /opt/
ADD https://github.com/sonatype-nexus-community/nexus-blobstore-google-cloud/archive/${GCBLOBSTORE_VERSION}.tar.gz /opt/

# Unpack and build Helm Plugin
RUN tar -xvzf /opt/v${HELM_VERSION}.tar.gz -C /opt && \
    cd /opt/nexus-repository-helm-${HELM_VERSION}/; sed -i "s/3.13.0-01/${NEXUS_VERSION}-${NEXUS_BUILD}/g" pom.xml; \
    mvn clean package;

# Unpack and build Blobstore backed by Google Cloud Storage
RUN tar -xvzf /opt/${GCBLOBSTORE_VERSION}.tar.gz -C /opt && \
    cd /opt/nexus-blobstore-google-cloud-${GCBLOBSTORE_VERSION} && \
    mvn clean install

FROM sonatype/nexus3:$NEXUS_VERSION
ARG NEXUS_VERSION=3.13.0
ARG NEXUS_BUILD=01
ARG HELM_VERSION=0.0.4
ARG GCBLOBSTORE_VERSION=0.2.0
ARG HELM_TARGET_DIR=/opt/sonatype/nexus/system/org/sonatype/nexus/plugins/nexus-repository-helm/${HELM_VERSION}/

# Copy Blobstore for Gooogle Cloud Storage plugin
ADD scripts/install-gcblobstore-plugin.sh /opt/plugins/nexus-blobstore-google-cloud/
COPY --from=build /opt/nexus-blobstore-google-cloud-${GCBLOBSTORE_VERSION}/target/ /opt/plugins/nexus-blobstore-google-cloud/target/
COPY --from=build /opt/nexus-blobstore-google-cloud-${GCBLOBSTORE_VERSION}/pom.xml /opt/plugins/nexus-blobstore-google-cloud/

USER root

# Install Helm Repository plugin
RUN mkdir -p ${HELM_TARGET_DIR}; \
    sed -i 's@nexus-repository-maven</feature>@nexus-repository-maven</feature>\n        <feature prerequisite="false" dependency="false">nexus-repository-helm</feature>@g' /opt/sonatype/nexus/system/org/sonatype/nexus/assemblies/nexus-core-feature/${NEXUS_VERSION}-${NEXUS_BUILD}/nexus-core-feature-${NEXUS_VERSION}-${NEXUS_BUILD}-features.xml; \
    sed -i 's@<feature name="nexus-repository-maven"@<feature name="nexus-repository-helm" description="org.sonatype.nexus.plugins:nexus-repository-helm" version="0.0.4">\n        <details>org.sonatype.nexus.plugins:nexus-repository-helm</details>\n        <bundle>mvn:org.sonatype.nexus.plugins/nexus-repository-helm/0.0.4</bundle>\n        <bundle>mvn:org.apache.commons/commons-compress/1.16.1</bundle>\n   </feature>\n    <feature name="nexus-repository-maven"@g' /opt/sonatype/nexus/system/org/sonatype/nexus/assemblies/nexus-core-feature/${NEXUS_VERSION}-${NEXUS_BUILD}/nexus-core-feature-${NEXUS_VERSION}-${NEXUS_BUILD}-features.xml;

COPY --from=build /opt/nexus-repository-helm-${HELM_VERSION}/target/nexus-repository-helm-${HELM_VERSION}.jar ${HELM_TARGET_DIR}

# Install Blobstore for Gooogle Cloud Storage plugin
RUN cd /opt/plugins/nexus-blobstore-google-cloud/ && \
    chmod +x install-gcblobstore-plugin.sh && \
    ./install-gcblobstore-plugin.sh /opt/sonatype/nexus/ && \
    rm -rf /opt/plugins/nexus-blobstore-google-cloud/ && \
    chown -R nexus:nexus /opt/sonatype/

USER nexus