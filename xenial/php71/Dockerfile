FROM charlesportwoodii/xenial:base
ENV DEBIAN_FRONTEND noninteractive
LABEL maintainer="Charles R. Portwood II <charlesportwoodii@erianna.com>"

ENV XDEBUG_VERSION 2.5.5
ENV PHP_VERSION 7.1

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_NO_INTERACTION 1

RUN apt-get update && \
    apt-get install libxslt1-dev libpng12-0 libfreetype6 build-essential make automake autoconf git php7.1-fpm --no-install-recommends -y && \
    apt-get install php7.1-soap php7.1-argon2 php7.1-bz2 php7.1-enchant php7.1-gd php7.1-gmp php7.1-intl php7.1-mysql php7.1-ldap php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-recode php7.1-redis php7.1-sqlite3 php7.1-xml php7.1-xsl php7.1-zip php7.1-opcache php7.1-sodium --no-install-recommends -y && \
    rm -rf /etc/php/${PHP_VERSION}/mods-available/mods-available && \
    mkdir -p /etc/php/${PHP_VERSION}/conf.d /etc/php/${PHP_VERSION}/php-fpm.d /etc/php/${PHP_VERSION}/mods-available /var/run/php/ /var/log/php/ && \
    for i in $(ls /etc/php/${PHP_VERSION}/mods-available); do ln -s /etc/php/${PHP_VERSION}/mods-available/$i /etc/php/${PHP_VERSION}/conf.d/$i; done && \
    apt-get install php-pear -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/etc/php/${PHP_VERSION}/php-fpm.d/pool.conf /etc/php/${PHP_VERSION}/php-fpm.d/pool.conf
COPY ./conf/etc/php/${PHP_VERSION}/php-fpm.conf /etc/php/${PHP_VERSION}/php-fpm.conf

RUN cd /tmp && \
    wget http://xdebug.org/files/xdebug-${XDEBUG_VERSION}.tgz && \
    tar -xf xdebug-${XDEBUG_VERSION}.tgz && \
    cd xdebug-${XDEBUG_VERSION} && \
    phpize && \
    ./configure && make install && \
    echo "zend_extension=xdebug.so" | tee /etc/php/${PHP_VERSION}/conf.d/xdebug.ini && \
    echo "xdebug.remote_enable=1" | tee --append  /etc/php/${PHP_VERSION}/conf.d/xdebug.ini && \
    echo "xdebug.remote_autostart=1" | tee --append /etc/php/${PHP_VERSION}/conf.d/xdebug.ini && \
    rm -rf /tmp/xdebug-*

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

RUN apt-get remove build-essential make automake autoconf --purge -y && \
    apt-get autoremove -y && \
    rm -rf /tmp/*

# Ensure pdo_mysql is installed
RUN grep -qF "extension=pdo_mysql.so" "/etc/php/${PHP_VERSION}/conf.d/mysql.ini" || echo "extension=pdo_mysql.so" >> "/etc/php/${PHP_VERSION}/conf.d/mysql.ini"

# Define mountable directories.
VOLUME ["/etc/php/7.1/", "/var/www"]

# Define working directory.
WORKDIR /etc/php/7.1

EXPOSE 9071

ENTRYPOINT ["/usr/sbin/php-fpm7.1", "-R", "--fpm-config", "/etc/php/7.1/php-fpm.conf"]
