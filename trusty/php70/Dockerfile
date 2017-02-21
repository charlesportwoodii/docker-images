FROM charlesportwoodii/trusty:base
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Charles R. Portwood II <charlesportwoodii@erianna.com>

COPY ./conf/etc/php/7.0/php-fpm.d/pool.conf /etc/php/7.0/php-fpm.d/pool.conf
COPY ./conf/etc/php/7.0/php-fpm.conf /etc/php/7.0/php-fpm.conf

RUN mkdir -p /etc/php/7.0/conf.d /etc/php/7.0/php-fpm.d /etc/php/7.0/mods-available /var/run/php/ /var/log/php/
RUN apt-get update && \
    apt-get install php7.0-fpm libpng12-0 libfreetype6 -y && \
    apt-get clean

# Define mountable directories.
VOLUME ["/etc/php/7.0/"]

# Define working directory.
WORKDIR /etc/php/7.0

EXPOSE 9070

ENTRYPOINT ["/usr/sbin/php-fpm7.0", "--fpm-config", "/etc/php/7.0/php-fpm.conf"]