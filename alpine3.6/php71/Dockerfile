FROM charlesportwoodii/alpine3.6:base
LABEL reference="https://github.com/charlesportwoodii/docker-images"
LABEL repository="https://github.com/charlesportwoodii/php-fpm-build"
LABEL maintainer="Charles R. Portwood II <charlesportwoodii@erianna.com>"
LABEL description="An PHP 7.1 Docker image with XDebug, Composer, Libsodium, Argon2, and other common extensions pre-installed"

ENV XDEBUG_VERSION 2.5.5
ENV PHP_VERSION 7.1

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_NO_INTERACTION 1
ENV COMPOSER_HASH 544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061

RUN apk update && \
    apk add git ca-certificates openssl alpine-sdk make automake gcc autoconf php7.1-common php7.1-fpm php7.1-argon2 php7.1-bz2  php7.1-dev php7.1-enchant php7.1-gd php7.1-gmp php7.1-intl php7.1-ldap php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-opcache php7.1-pgsql php7.1-pspell php7.1-recode php7.1-redis php7.1-soap php7.1-sodium php7.1-sqlite3 php7.1-xml php7.1-xsl php7.1-zip && \
    rm -rf /etc/php/${PHP_VERSION}/mods-available/mods-available && \
    mkdir -p /etc/php/${PHP_VERSION}/conf.d /etc/php/${PHP_VERSION}/php-fpm.d /etc/php/${PHP_VERSION}/mods-available /var/run/php/ /var/log/php/ && \
    for i in $(ls /etc/php/${PHP_VERSION}/mods-available); do ln -s /etc/php/${PHP_VERSION}/mods-available/$i /etc/php/${PHP_VERSION}/conf.d/$i; done && \
    rm -rf /var/cache/apk/* && \
    ln -s /usr/bin/phpize${PHP_VERSION} /usr/bin/phpize && \
    ln -s /usr/bin/php-config${PHP_VERSION} /usr/bin/php-config && \
    ln -s /usr/bin/php${PHP_VERSION} /usr/bin/php

COPY ./conf/etc/php/${PHP_VERSION}/php-fpm.d/pool.conf /etc/php/${PHP_VERSION}/php-fpm.d/pool.conf
COPY ./conf/etc/php/${PHP_VERSION}/php-fpm.conf /etc/php/${PHP_VERSION}/php-fpm.conf

RUN cd /tmp && \
    wget http://xdebug.org/files/xdebug-${XDEBUG_VERSION}.tgz && \
    tar -xf xdebug-${XDEBUG_VERSION}.tgz && \
    cd xdebug-${XDEBUG_VERSION} && \
    phpize && \
    ./configure && make install && \
    echo "zend_extension=xdebug.so" | tee /etc/php/${PHP_VERSION}/conf.d/xdebug.ini && \
    echo "xdebug.remote_enable=1" | tee -a  /etc/php/${PHP_VERSION}/conf.d/xdebug.ini && \
    echo "xdebug.remote_autostart=1" | tee -a /etc/php/${PHP_VERSION}/conf.d/xdebug.ini && \
    rm -rf /tmp/xdebug-*

RUN echo "export PATH=\"\$PATH:\$HOME/.bin\"" >> /root/.bashrc && \
    mkdir -p /root/.bin && \
    chown -R root:root /root/.bin && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" > composer-setup.php && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '${COMPOSER_HASH}') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/root/.bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    chmod a+x /root/.bin/composer && \
    chown -R root:root /root/.bin/composer && \
    /root/.bin/composer global require hirak/prestissimo && \
    /root/.bin/composer self-update

RUN apk del alpine-sdk make automake gcc autoconf && \
    rm -rf /var/cache/apk/*

# Ensure pdo_mysql is installed
RUN grep -qF "extension=pdo_mysql.so" "/etc/php/${PHP_VERSION}/conf.d/mysql.ini" || echo "extension=pdo_mysql.so" >> "/etc/php/${PHP_VERSION}/conf.d/mysql.ini"

# Define mountable directories.
VOLUME ["/etc/php/7.1/", "/var/www"]

# Define working directory.
WORKDIR /etc/php/7.1

EXPOSE 9070

ENTRYPOINT ["/usr/sbin/php-fpm7.1", "-R", "--fpm-config", "/etc/php/7.1/php-fpm.conf"]

