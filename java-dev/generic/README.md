# Java Maven Development Image

This image is based on [maven one](https://hub.docker.com/_/maven).

### Features

- git

## JDK 11 with OpenJ9

You can find the last tags [here](https://hub.docker.com/r/bmeme/mn-dev/tags?page=1&ordering=last_updated&name=-openj9).

```
$ JDK_VARIANT=jdk-11-openj9 && \
  MAVEN_VERSION=3.8.3 && \
  docker build \
    --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
    --build-arg JDK_VARIANT=${JDK_VARIANT} \
    --build-arg MAVEN_VERSION=${MAVEN_VERSION} \
    -t bmeme/java-dev:${MAVEN_VERSION}-${JDK_VARIANT} \
    -f Dockerfile .
```
