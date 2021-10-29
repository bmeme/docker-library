FROM maven:3.8.1-jdk-11-openj9
LABEL maintainer="Michele Mondelli <michele.mondelli@bmeme.com>"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends \
        -y git libgl1 xserver-xorg-core libgl1-mesa-glx openjfx && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

