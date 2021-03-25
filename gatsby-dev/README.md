# Gatsby Development Image

![Gatsby JS Logo](https://www.cmswire.com/-/media/734f9fb4033b4f92b3d9babc0d72da41.ashx?mw=320&mh=240)

[Gatsby JS](https://www.gatsbyjs.com/) is a «free, open source framework for building fast, powerful websites.».

This image is based on [node one](https://hub.docker.com/_/node).

You can download the docker image from [Docker HUB](https://hub.docker.com/r/bmeme/gatsby-dev).

# Details

The image comes in two flavours.

## Standard image

A standard node LTS image with Gatsby CLI installed.

Latest is `bmeme/gatsby-dev:3.1.0` ([link](https://hub.docker.com/r/bmeme/gatsby-dev/tags?page=1&ordering=last_updated)).

### Features

- node LTS
- Gatsby CLI

## Starter image

It's the same as the standard image but also ships with `git` command, needed to run `gatsby new`.
Use this version only to create a new gatsby project, than switch to the standard one.

Latest is `bmeme/gatsby-dev:3.1.0-starter` ([link](https://hub.docker.com/r/bmeme/gatsby-dev/tags?page=1&ordering=last_updated)).

### Features

- node LTS
- Gatsby CLI
- git

# Building commands

## Standard image

```
$ GATSBY_VERSION=3.1.0 && \
  NODE_VERSION=14.16.0 && \
  docker build \
    --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
    --build-arg GATSBY_VERSION=${GATSBY_VERSION} \
    --build-arg NODE_VERSION=${NODE_VERSION} \
    -t bmeme/gatsby-dev:${GATSBY_VERSION} .
```

## Starter image

```
$ GATSBY_VERSION=3.1.0 && \
  NODE_VERSION=14.16.0 && \
  docker build \
    --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
    --build-arg GATSBY_VERSION=${GATSBY_VERSION} \
    --build-arg NODE_VERSION=${NODE_VERSION} \
    -t bmeme/gatsby-dev:${GATSBY_VERSION}-starter \
    -f Dockerfile-starter .
```
