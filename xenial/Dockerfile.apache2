FROM charlesportwoodii/xenial:base
ENV DEBIAN_FRONTEND noninteractive
LABEL maintainer="Charles R. Portwood II <charlesportwoodii@erianna.com>"

RUN echo "deb http://ppa.launchpad.net/ondrej/apache2/ubuntu xenial main" | tee --append /etc/apt/sources.list.d/ondrej-apache2.list && \
    echo "deb-src http://ppa.launchpad.net/ondrej/apache2/ubuntu xenial main" | tee --append /etc/apt/sources.list.d/ondrej-apache2.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C

RUN mkdir -p /etc/apache2/conf/certs && \
    mkdir -p /etc/apache2/sites-enabled && \
    mkdir -p /var/log/apache2 && \
    ln -sf /proc/self/fd/1 /var/log/apache2/access.log && \
    ln -sf /proc/self/fd/1 /var/log/apache2/error.log

RUN apt-get update && \
    apt-get install apache2 libapache2-mod-fastcgi libapache2-mod-gnutls libapache2-mod-geoip libapache2-modsecurity libapache2-mod-security2 -y && \
    apt-get autoremove -y && \
    apt-get clean && \
    apt-get autoclean && \
    a2enmod rewrite && \
    a2dismod gnutls && \
    a2enmod ssl && \
    a2enmod headers && \
    a2enmod proxy_fcgi && \
    a2enmod proxy_http && \
    a2enmod proxy_ajp && \
    a2enmod proxy_wstunnel && \
    apt-get purge -y --auto-remove && \
    rm -rf /var/lib/apt/lists/*
    
VOLUME ["/var/www/", "/etc/apache2/sites-enabled", "/etc/apache2/conf/certs"]

WORKDIR /etc/apache2

EXPOSE 80 443

ENTRYPOINT ["/usr/sbin/apache2ctl","-D", "FOREGROUND"]
