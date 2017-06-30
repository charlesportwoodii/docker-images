FROM charlesportwoodii/xenial:base
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Charles R. Portwood II <charlesportwoodii@erianna.com>

COPY ./conf/etc/php/7.1/php-fpm.d/pool.conf /etc/php/7.1/php-fpm.d/pool.conf
COPY ./conf/etc/php/7.1/php-fpm.conf /etc/php/7.1/php-fpm.conf

RUN mkdir -p /etc/php/7.1/conf.d /etc/php/7.1/php-fpm.d /etc/php/7.1/mods-available /var/run/php/ /var/log/php/
RUN apt-get update && \
    apt-get install php7.1-fpm libpng12-0 libfreetype6 -y && \
    apt-get clean

# Define mountable directories.
VOLUME ["/etc/php/7.1/", "/var/www"]

# Define working directory.
WORKDIR /etc/php/7.1

EXPOSE 9071

ENTRYPOINT ["/usr/sbin/php-fpm7.1", "--fpm-config", "/etc/php/7.1/php-fpm.conf"]