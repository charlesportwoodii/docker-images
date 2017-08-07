FROM charlesportwoodii/xenial-test:php71
ENV DEBIAN_FRONTEND nointeractive
MAINTAINER charlesportwoodii@erianna.com

COPY ./build/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm /tmp/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm
COPY ./build/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm /tmp/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm

RUN apt-get update && \
    apt-get install alien libaio1 --no-install-recommends -y && \
    alien -iv /tmp/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm && \
    alien -iv /tmp/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm && \
    rm -rf /tmp/*.rpm && \
    for i in $(ls /usr/lib/oracle/12.2/client64/lib/*.so); do ln -s $i /usr/lib/; done && \
    for i in $(ls /usr/lib/oracle/12.2/client64/lib/*.so.12.1); do ln -s $i /usr/lib/; done && \
    wget https://deb.erianna.com/amd64/xenial-extra/php7.1-oci8-2.1.4~xenial_x86_64.deb && \
    dpkg -i php7.1-oci8-2.1.4~xenial_x86_64.deb && \
    rm -rf php7.1-oci8-2.1.4~xenial_x86_64.deb && \
    cp /etc/php/7.1/mods-available/oci8.ini /etc/php/7.1/conf.d/oci8.ini && \
    apt-get remove alien --purge -y && \
    apt-get autoremove -y && \
    apt-get clean && \ 
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/*
