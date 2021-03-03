```
$ GATSBY_VERSION=3.0.0 && NODE_VERSION=14.16.0 && docker build --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg GATSBY_VERSION=${GATSBY_VERSION} --build-arg NODE_VERSION=${NODE_VERSION}-t bmeme/gatsby-dev:${GATSBY_VERSION}-${NODE_VERSION}-buster-slim .
```
