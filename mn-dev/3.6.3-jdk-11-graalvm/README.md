```
$ MN_VERSION=2.3.1 && docker build --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg MN_VERSION=${MN_VERSION} -t bmeme/mn-dev:${MN_VERSION}-jdk-11-graalvm .
```
