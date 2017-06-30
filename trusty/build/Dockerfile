FROM charlesportwoodii/trusty:base
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Charles R. Portwood II <charlesportwoodii@erianna.com>

# Install Postgresql
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN mkdir -p /usr/lib64 && \
    ln -sf /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib64/libldap.so && \
    ln -sf /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib64/liblber.so && \
    ln -sf /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h

# Install build tools
RUN apt-get update --fix-missing && \
    apt-get install m4 autogen apt-utils postgresql-contrib-9.6 postgresql-server-dev-9.6 make automake g++ autoconf checkinstall git build-essential libxml2-dev pkg-config libjpeg-turbo8-dev libpng12-dev libfreetype6-dev libicu-dev libmcrypt4 libmcrypt-dev libreadline6-dev libtool build-essential git ruby ruby-dev lsb-release libgmp-dev libunbound-dev libtasn1-6 libtasn1-6-dev zlib1g-dev libpcre3 libpcre3-dev libluajit-5.1-common luajit libgeoip-dev geoip-database libluajit-5.1-dev luajit unzip libgmp-dev libunbound-dev python2.7 python-dev lsb-release apt-transport-https bc libbrotli luajit-2.0 libnettle2 libxslt-dev libbz2-dev libenchant-dev libldap2-dev libpspell-dev librecode-dev libgmp3-dev -y

# Install Bison
RUN wget http://launchpadlibrarian.net/140087283/libbison-dev_2.7.1.dfsg-1_amd64.deb && \
    dpkg -i libbison-dev_2.7.1.dfsg-1_amd64.deb && \
    rm libbison-dev_2.7.1.dfsg-1_amd64.deb
RUN wget http://launchpadlibrarian.net/140087282/bison_2.7.1.dfsg-1_amd64.deb && \
    dpkg -i bison_2.7.1.dfsg-1_amd64.deb && \
    rm bison_2.7.1.dfsg-1_amd64.deb

# Install FPM
RUN gem install fpm

# Clean the repository data
RUN apt-get clean -y && \
    apt-get autoclean -y