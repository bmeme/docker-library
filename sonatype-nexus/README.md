## Overview

A [Sonatype Nexus](https://www.sonatype.com/nexus-repository-sonatype) docker image ready to be deployed on your Kubernetes Cluster.

What differentiates this repository with the original Docker repository [sonatype/nexus3](https://hub.docker.com/r/sonatype/nexus3/) and, mostly, with the [_Travel Audience_ quay repository](https://quay.io/repository/travelaudience/docker-nexus) is that this Nexus Docker image contains also the [HELM Repository plugin](https://github.com/sonatype-nexus-community/nexus-repository-helm), enabling this kind of feature not officially supported by the standard Sonatype Nexus installation.

To maintain the greatest possible compatibility with the [stable helm chart(https://github.com/helm/charts/tree/master/stable/sonatype-nexus), this Sonatype Nexus image is based on the [Travel Audience](https://travelaudience.com/) Docker image (thanks for their precious work).  

Dockerfile is mostly taken by the [Nexus Repository Helm project](https://github.com/sonatype-nexus-community/nexus-repository-helm/blob/master/Dockerfile).

## How to use
Basically you can find all information you need at [sonatype/nexus3](https://hub.docker.com/r/sonatype/nexus3/) Docker Hub page; this because, the "official" sonatype/nexus docker image and the _travelaudience_ port for Kubernetes are really similar.

## Kubernetes deploy
This project includes in "_kubernetes_" folder, an example of manifest you can use to deploy this image in your Kubernetes Cluster.

## Credits:
* [Nexus Repository Helm Format](https://github.com/sonatype-nexus-community/nexus-repository-helm)
* [TravelAudience Docker Nexus Project](https://quay.io/repository/travelaudience/docker-nexus)
* [Official Sonatype Nexus3 Docker Project](https://hub.docker.com/r/sonatype/nexus3/)

## Maintaining
This Docker Library in actually maintained by [Daniele Piaggesi](mailto:daniele.piaggesi@bmeme.com) of [Bmeme](http://www.bmeme.com). Any contribution will be really appreciated.