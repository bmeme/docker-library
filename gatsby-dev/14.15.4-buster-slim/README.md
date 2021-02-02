```
$ GATSBY_VERSION=2.18.0 && docker build --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg GATSBY_VERSION=${GATSBY_VERSION} -t bmeme/gatsby-dev:${GATSBY_VERSION}-14.15.4-buster-slim .
```
