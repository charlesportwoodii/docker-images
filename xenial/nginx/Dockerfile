FROM charlesportwoodii/xenial:base
ENV DEBIAN_FRONTEND noninteractive
LABEL maintaner="Charles R. Portwood II <charlesportwoodii@erianna.com>"

RUN apt-get update && \
    apt-get install nginx-mainline -y && \
    apt-get clean && \
    apt-get purge -y --auto-remove && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/conf/conf.d /etc/nginx/conf/includes /var/www && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

# Define mountable directories.
VOLUME ["/etc/nginx/conf/conf.d", "/etc/nginx/conf/includes", "/etc/nginx/conf/ssl", "/var/www/"]

# Define working directory.
WORKDIR /etc/nginx

EXPOSE 80 443

ENTRYPOINT ["/usr/bin/nginx", "-g", "daemon off;"]