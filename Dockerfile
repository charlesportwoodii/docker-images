FROM centos:centos7
MAINTAINER "https://github.com/charlesportwoodii/docker-images"

# Install pre-dependencies
RUN yum install wget -y

# Install EPEL
RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install epel-release-latest-7.noarch.rpm -y

# Install Postgresql
RUN wget https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-2.noarch.rpm
RUN yum install pgdg-centos95-9.5-2.noarch.rpm -y

# Upgrade
RUN yum update -y
RUN yum upgrade -y

# Install base dependencies
RUN yum group install "Development Tools" -y
RUN yum install make automake autoconf which bc geoip geoip-devel g++ build-essential glib2-devel glibc-devel git libmcrypt-devel libmcrypt gcc libtool libxml2-devel libicu-devel gcc-c++ bison libpng12-devel libjpeg-turbo readline-devel postgresql95-devel freetype-devel libjpeg-turbo-devel postgresql-devel ruby ruby-devel -y

# Install Erianna RPM Repo and necessary extra packages
RUN sh -c 'echo -e "[erianna]\nname=Erianna RPM Repository\nbaseurl=https://rpm.erianna.com/CentOS/7/x86_64\nenabled=1\ngpgcheck=0\nprotect=1\ngpgkey=https://gist.githubusercontent.com/charlesportwoodii/6cc11c2b7ca50932a81049d9e1a1d027/raw/91f82a3a9d7b427daa30413160489f008c735799/761B989F0120C4444DF755C094F981FCCA91BE86.pub" > /etc/yum.repos.d/rpm.erianna.com.repo'
RUN yum --enablerepo=erianna clean metadata
RUN yum install libbrotli luajit-2.0 -y

RUN ldconfig

# Install FPM
RUN gem install fpm
