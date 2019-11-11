FROM itsthenetwork/nfs-server-alpine:12
LABEL maintainer "Daniele Piaggesi <daniele.piaggesi@bmeme.com>"
LABEL source "https://github.com/bmeme/docker-library/tree/master/nfs-server"
LABEL branch "master"

COPY nfsd.sh /usr/bin/nfsd.sh
RUN chmod +x /usr/bin/nfsd.sh