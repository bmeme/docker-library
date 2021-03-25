# Micronaut Development Environment

![Micronaut Registered](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKDqbCPQkcDra0qtJnYPvyvO9ECnAdEcIDfQ&usqp=CAU)

[Micronaut](https://micronaut.io/) is «a modern, JVM-based, full-stack framework for building modular, easily testable microservice and serverless applications».

This image is based on [maven one](https://hub.docker.com/_/maven).

### Features

- git
- zip/unzip
- Micronaut CLI

## JDK 11 with OpenJ9

You can find the last tags [here](https://hub.docker.com/r/bmeme/mn-dev/tags?page=1&ordering=last_updated&name=-openj9).

```
$ MN_VERSION=2.4.1 && \
  MAVEN_VERSION=3.6.3 && \
  docker build \
    --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
    --build-arg MN_VERSION=${MN_VERSION} \
    --build-arg MAVEN_VERSION=${MAVEN_VERSION} \
    -t bmeme/mn-dev:${MN_VERSION}-jdk-11-openj9 \
    -f Dockerfile-openj9 .
```

## JDK 11 with GraalVM and native image support

You can find the last tags [here](https://hub.docker.com/r/bmeme/mn-dev/tags?page=1&ordering=last_updated&name=-graalvm).

```
$ MN_VERSION=2.4.1 && \
  GRAALVM_VERSION=20.3.0 && \
  MAVEN_VERSION=3.6.3 && \
  docker build \
    --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
    --build-arg MN_VERSION=${MN_VERSION} \
    --build-arg GRAALVM_VERSION=${GRAALVM_VERSION} \
    --build-arg MAVEN_VERSION=${MAVEN_VERSION} \
    -t bmeme/mn-dev:${MN_VERSION}-jdk-11-graalvm \
    -f Dockerfile-graalvm .
```
