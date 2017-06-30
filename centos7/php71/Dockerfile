FROM charlesportwoodii/centos7:base
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Charles R. Portwood II <charlesportwoodii@erianna.com>

COPY ./conf/etc/php/7.1/php-fpm.d/pool.conf /etc/php/7.1/php-fpm.d/pool.conf
COPY ./conf/etc/php/7.1/php-fpm.conf /etc/php/7.1/php-fpm.conf

RUN mkdir -p /etc/php/7.1/conf.d /etc/php/7.1/php-fpm.d /etc/php/7.1/mods-available /var/run/php/ /var/log/php/
RUN yum install php7.1-fpm libpng libpng12 freetype freetype-devel -y && \
    yum clean all

RUN echo "export PATH=\"\$PATH:\$HOME/.bin\"" >> /root/.bashrc && \
    mkdir -p /root/.bin && \
    chown -R root:root /root/.bin && \
    php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php && \
    php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === '7228c001f88bee97506740ef0888240bd8a760b046ee16db8f4095c0d8d525f2367663f22a46b48d072c816e7fe19959') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/root/.bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    chmod a+x /root/.bin/composer && \
    chown -R root:root /root/.bin/composer && \
    /root/.bin/composer global require hirak/prestissimo && \
    /root/.bin/composer global require "fxp/composer-asset-plugin:^1.3.1" && \
    /root/.bin/composer self-update

RUN for i in $(ls /etc/php/7.1/mods-available); do ln -s /etc/php/7.1/mods-available/$i /etc/php/7.1/conf.d/$i; done;

# Define mountable directories.
VOLUME ["/etc/php/7.1/", "/var/www"]

# Define working directory.
WORKDIR /etc/php/7.1

EXPOSE 9071

ENTRYPOINT ["/usr/sbin/php-fpm7.1", "--fpm-config", "/etc/php/7.1/php-fpm.conf"]