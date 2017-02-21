FROM charlesportwoodii/rhel7:base
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Charles R. Portwood II <charlesportwoodii@erianna.com>

COPY ./.secrets /
RUN source /.secrets \
    && subscription-manager register --username=$REDHAT_USER --password=$REDHAT_PASS --auto-attach && \
    subscription-manager repos --enable rhel-7-server-optional-rpms && \
    rm -rf /.secrets \
    && export REDHAT_PASS=""

COPY ./conf/etc/nginx/conf/nginx.conf /etc/nginx/conf/nginx.conf
COPY ./conf/etc/nginx/conf/conf.d/server.conf /etc/nginx/conf/conf.d/server.conf

RUN yum install nginx-mainline -y

RUN useradd -r www-data && \
    mkdir -p /etc/nginx/conf/conf.d /etc/nginx/conf/includes /var/www && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

# Define mountable directories.
VOLUME ["/etc/nginx/conf/conf.d", "/etc/nginx/conf/includes", "/etc/nginx/conf/ssl", "/var/www/"]

# Define working directory.
WORKDIR /etc/nginx

EXPOSE 80 443

ENTRYPOINT ["/usr/bin/nginx", "-g", "daemon off;"]

# Unregister the docker image
RUN subscription-manager unregister