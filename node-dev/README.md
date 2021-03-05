```
$ NODE_VERSION=14.16.0 && docker build --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg NODE_VERSION=${NODE_VERSION} -t bmeme/node-dev:${NODE_VERSION}-buster-slim .
```
