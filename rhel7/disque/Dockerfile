FROM charlesportwoodii/rhel7:base
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Charles R. Portwood II <charlesportwoodii@erianna.com>

RUN yum install disque-server -y && \
    yum clean all

RUN curl -o /etc/disque/disque.conf https://raw.githubusercontent.com/antirez/disque/master/disque.conf

EXPOSE 7711

ENTRYPOINT ["/usr/local/bin/disque-server", "/etc/disque/disque.conf"]