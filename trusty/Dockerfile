FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive

# Install pre-dependencies
RUN apt-get update
RUN apt-get install wget m4 -y

# Install Postgresql
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Install build tools
RUN apt-get update --fix-missing
RUN apt-get install autogen apt-utils postgresql-contrib-9.6 postgresql-server-dev-9.6 make automake g++ autoconf checkinstall git build-essential libxml2-dev pkg-config libjpeg-turbo8-dev libpng12-dev libfreetype6-dev libicu-dev libmcrypt4 libmcrypt-dev libreadline6-dev libtool build-essential git ruby ruby-dev lsb-release libgmp-dev libunbound-dev libtasn1-6 libtasn1-6-dev zlib1g-dev libpcre3 libpcre3-dev libluajit-5.1-common luajit libgeoip-dev geoip-database libluajit-5.1-dev luajit unzip libgmp-dev libunbound-dev python2.7 python-dev lsb-release apt-transport-https bc -y

# Install Bison
RUN wget http://launchpadlibrarian.net/140087283/libbison-dev_2.7.1.dfsg-1_amd64.deb
RUN wget http://launchpadlibrarian.net/140087282/bison_2.7.1.dfsg-1_amd64.deb
RUN dpkg -i libbison-dev_2.7.1.dfsg-1_amd64.deb
RUN dpkg -i bison_2.7.1.dfsg-1_amd64.deb

# Add our deb repository
RUN sh -c 'echo "deb http://deb.erianna.com trusty main" > /etc/apt/sources.list.d/deb.erianna.com.list'

# Install GNUPG2 for ECDSA key support
RUN apt-get --allow-unauthenticated update
RUN apt-get --allow-unauthenticated install gnupg2 gnutls3 -y
RUN gpg --version

RUN ldconfig

# Download ECC key from Keybase
RUN wget --quiet -O - https://gist.githubusercontent.com/charlesportwoodii/702abdf8dae5164f4917e78cf256a480/raw/afa856ff3e1ca2205c5ffeed943bbbaea79b4944/398ECFC4.pub | apt-key add -
RUN wget -qO - https://gist.githubusercontent.com/charlesportwoodii/6cc11c2b7ca50932a81049d9e1a1d027/raw/91f82a3a9d7b427daa30413160489f008c735799/761B989F0120C4444DF755C094F981FCCA91BE86.pub | apt-key add -
RUN apt-get update
RUN apt-get install libbrotli luajit-2.0 libnettle2 -y

RUN ldconfig

# Install FPM
RUN gem install fpm

RUN apt-get clean -y
RUN apt-get autoclean -y
