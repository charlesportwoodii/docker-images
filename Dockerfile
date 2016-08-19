FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive

# Install pre-dependencies
RUN apt-get update
RUN apt-get install wget m4 -y

# Install Postgresql
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Install build tools
RUN apt-get update
RUN apt-get install postgresql-contrib-9.5 postgresql-server-dev-9.5 make automake g++ autoconf checkinstall git build-essential libxml2-dev pkg-config libjpeg-turbo8-dev libpng12-dev libfreetype6-dev libicu-dev libmcrypt4 libmcrypt-dev libreadline6-dev libtool ruby ruby-dev lsb-release libgmp-dev libunbound-dev libtasn1-6 libtasn1-6-dev zlib1g-dev libpcre3 libpcre3-dev libluajit-5.1-common luajit libgeoip-dev geoip-database libluajit-5.1-dev luajit unzip libgmp-dev libunbound-dev python2.7 python-dev lsb-release apt-transport-https bc -y

# Install Bison
RUN wget http://launchpadlibrarian.net/140087283/libbison-dev_2.7.1.dfsg-1_amd64.deb
RUN wget http://launchpadlibrarian.net/140087282/bison_2.7.1.dfsg-1_amd64.deb
RUN dpkg -i libbison-dev_2.7.1.dfsg-1_amd64.deb
RUN dpkg -i bison_2.7.1.dfsg-1_amd64.deb

# Add our deb repository
RUN sh -c 'echo "deb https://deb.erianna.com xenial main" > /etc/apt/sources.list.d/deb.erianna.com.list'

# Install GNUPG2 for ECDSA key support
RUN apt-get --allow-unauthenticated update
RUN apt-get --allow-unauthenticated install gnupg2 gnutls3 -y
RUN gpg --version

RUN ldconfig

# Download ECC key from Keybase
RUN wget --quiet -O - https://keybase.io/charlesportwood/key.asc | apt-key add -
RUN apt-get update
RUN apt-get install libbrotli luajit-2.0 libbrotli -y

# Install FPM
RUN gem install fpm
