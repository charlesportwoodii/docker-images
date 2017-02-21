FROM charlesportwoodii/trusty:base
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Charles R. Portwood II <charlesportwoodii@erianna.com>

RUN apt-get update && \
    apt-get install disque-server && \
    apt-get clean

RUN curl -o /etc/disque/disque.conf https://raw.githubusercontent.com/antirez/disque/master/disque.conf

EXPOSE 7711

ENTRYPOINT ["/usr/local/bin/disque-server", "/etc/disque/disque.conf"]