FROM charlesportwoodii/centos7:base
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Charles R. Portwood II <charlesportwoodii@erianna.com>

COPY ./conf/etc/php/7.1/php-fpm.d/pool.conf /etc/php/7.1/php-fpm.d/pool.conf
COPY ./conf/etc/php/7.1/php-fpm.conf /etc/php/7.1/php-fpm.conf

RUN mkdir -p /etc/php/7.1/conf.d /etc/php/7.1/php-fpm.d /etc/php/7.1/mods-available /var/run/php/ /var/log/php/
RUN yum install php7.1-fpm libpng libpng12 freetype freetype-devel -y && \
    yum clean all

# Define mountable directories.
VOLUME ["/etc/php/7.1/"]

# Define working directory.
WORKDIR /etc/php/7.1

EXPOSE 9071

ENTRYPOINT ["/usr/sbin/php-fpm7.1", "--fpm-config", "/etc/php/7.1/php-fpm.conf"]