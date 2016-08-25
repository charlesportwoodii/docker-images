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
RUN yum install make automake autoconf g++ build-essential glib2-devel glibc-devel git libmcrypt-devel libmcrypt gcc libtool libxml2-devel libicu-devel gcc-c++ bison libpng12-devel libjpeg-turbo readline-devel postgresql95-devel freetype-devel libjpeg-turbo-devel postgresql-devel ruby ruby-devel -y

RUN ldconfig

# Install FPM
RUN gem install fpm
