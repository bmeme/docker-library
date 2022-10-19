
```
JRE_VERSION="11.0.16.1_1-jre-jammy" && \
docker build --pull --no-cache --build-arg JRE_VERSION="${JRE_VERSION}" -t "bmeme/mule-standalone:4.4.0-20220919-temurin-${JRE_VERSION}" .
```

```
docker push bmeme/mule-standalone:4.4.0-20220919-temurin-11.0.16.1_1-jre-jammy
```

https://hub.docker.com/r/bmeme/mule-standalone/tags

