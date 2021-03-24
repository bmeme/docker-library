```
$ NODE_VERSION=14.16.0 && NG_CLI_VERSION=11.2.5 && docker build --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg NODE_VERSION=${NODE_VERSION} --build-arg NG_CLI_VERSION=${NG_CLI_VERSION} -t bmeme/angular-dev:${NG_CLI_VERSION}-${NODE_VERSION} .
```
