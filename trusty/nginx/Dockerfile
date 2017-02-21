FROM charlesportwoodii/trusty:base
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Charles R. Portwood II <charlesportwoodii@erianna.com>

COPY ./conf/etc/nginx/conf/nginx.conf /etc/nginx/conf/nginx.conf
COPY ./conf/etc/nginx/conf/conf.d/server.conf /etc/nginx/conf/conf.d/server.conf

RUN apt-get update && \
    apt-get install nginx-mainline -y && \
    apt-get clean

RUN mkdir -p /etc/nginx/conf/conf.d /etc/nginx/conf/includes /var/www && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

# Define mountable directories.
VOLUME ["/etc/nginx/conf/conf.d", "/etc/nginx/conf/includes", "/etc/nginx/conf/ssl", "/var/www/"]

# Define working directory.
WORKDIR /etc/nginx

EXPOSE 80 443

ENTRYPOINT ["/usr/bin/nginx", "-g", "daemon off;"]