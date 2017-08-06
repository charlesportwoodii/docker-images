FROM charlesportwoodii/xenial:base
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Charles R. Portwood II <charlesportwoodii@erianna.com>

ENV XDEBUG_VERSION 2.5.5
ENV LIBSODIUM_VERSION 1.0.13
ENV SODIUM_EXT_VERSION 2.0.4
ENV PHP_VERSION 7.0

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_NO_INTERACTION 1

COPY ./conf/etc/php/${PHP_VERSION}/php-fpm.d/pool.conf /etc/php/${PHP_VERSION}/php-fpm.d/pool.conf
COPY ./conf/etc/php/${PHP_VERSION}/php-fpm.conf /etc/php/${PHP_VERSION}/php-fpm.conf

RUN mkdir -p /etc/php/${PHP_VERSION}/conf.d /etc/php/${PHP_VERSION}/php-fpm.d /etc/php/${PHP_VERSION}/mods-available /var/run/php/ /var/log/php/
RUN apt-get update && \
    apt-get install php${PHP_VERSION}-fpm libpng12-0 libfreetype6 build-essential make automake autoconf git --no-install-recommends -y && \
    apt-get install php-pear -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
    wget http://xdebug.org/files/xdebug-${XDEBUG_VERSION}.tgz && \
    tar -xf xdebug-${XDEBUG_VERSION}.tgz && \
    cd xdebug-${XDEBUG_VERSION} && \
    phpize && \
    ./configure && make install && \
    echo "zend_extension=xdebug.so" | tee /etc/php/${PHP_VERSION}/conf.d/xdebug.ini && \
    echo "xdebug.remote_enable=1" | tee --append  /etc/php/${PHP_VERSION}/conf.d/xdebug.ini && \
    echo "xdebug.remote_autostart=1" | tee --append /etc/php/${PHP_VERSION}/conf.d/xdebug.ini && \
    rm -rf /tmp/xdebug-${XDEBUG_VERSION}

RUN cd /tmp && \
    wget https://download.libsodium.org/libsodium/releases/libsodium-${LIBSODIUM_VERSION}.tar.gz && \
    tar -xzf libsodium-${LIBSODIUM_VERSION}.tar.gz && \
    cd libsodium-${LIBSODIUM_VERSION} && \
    ./configure && make install && \
    cd /tmp && \
    git clone https://github.com/jedisct1/libsodium-php -b ${SODIUM_EXT_VERSION} && \
    cd libsodium-php && \
    phpize && \
    ./configure && make install && \
    echo "extension=sodium.so" | tee --append /etc/php/${PHP_VERSION}/conf.d/sodium.ini && \
    rm -rf /tmp/libsodium-php && \
    rm -rf /tmp/libsodium-${LIBSODIUM_VERSION} && \
    rm -rf /tmp/libsodium-${LIBSODIUM_VERSION}.tar.gz

RUN echo "export PATH=\"\$PATH:\$HOME/.bin\"" >> /root/.bashrc && \
    mkdir -p /root/.bin && \
    chown -R root:root /root/.bin && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" > composer-setup.php && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/root/.bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    chmod a+x /root/.bin/composer && \
    chown -R root:root /root/.bin/composer && \
    /root/.bin/composer global require hirak/prestissimo && \
    /root/.bin/composer global require "fxp/composer-asset-plugin:^1.3.1" && \
    /root/.bin/composer self-update

RUN for i in $(ls /etc/php/${PHP_VERSION}/mods-available); do ln -s /etc/php/7.1/mods-available/$i /etc/php/${PHP_VERSION}/conf.d/$i; done;

RUN apt-get remove build-essential make automake autoconf --purge -y && \
    apt-get autoremove -y

RUN rm -rf /tmp/*

# Define mountable directories.
VOLUME ["/etc/php/7.0/", "/var/www"]

# Define working directory.
WORKDIR /etc/php/7.0

EXPOSE 9070

ENTRYPOINT ["/usr/sbin/php-fpm7.0", "-R", "--fpm-config", "/etc/php/7.0/php-fpm.conf"]