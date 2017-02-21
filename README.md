# Docker Images for TravisCI Builds

[![TravisCI](https://img.shields.io/travis/charlesportwoodii/docker-images.svg?style=flat-square&branch=master "TravisCI")](https://travis-ci.org/charlesportwoodii/docker-images)
[![License](https://img.shields.io/badge/license-BSD-orange.svg?style=flat-square "License")](https://github.com/charlesportwoodii/docker-images/blob/master/LICENSE.md)

## Introduction

For transparency purposes (and to reduce build time), I build all of my deb and rpm packages on TravisCI, then push them to deb.erianna.com and rpm.erianna.com, respectively. To ensure compatability with each OS that I build packages for, all packages are built on a docker container of the OS the package is built for.

The purpose of these boxes is primarily to ensure compatability with the OS packages are built for, and to reduce build times in Travis CI. These images are automatically pushed to DockerHub after they are built. 

## Supported Base Images

A full list of images that TravisCI builds is listed below. The created images will always be available on [DockerHub](https://hub.docker.com/r/charlesportwoodii/docker-images/tags/)

- Ubuntu 14.04 (trusty)
- Ubuntu 16.04 (xenial)
- CentOS 7
- RHEL 7*

> *RHEL7 builds are built against RedHat provided developer images. The built images is intended solely for the building of packages and for no other purpose. The image is _not_ registered or subscribed. If you wish to use the RHEL7 image you must subscribe it using your own developer credentials.

## Software Images

In addition to the `base` and `build` images, the following extra images are provided to showcase the packages that are built on TravisCI.

### Disque

Disque is a distributed job server (see https://github.com/antirez/disque).

The following command will start a disque server running on the OS of your choice on the selected port:

```bash
docker run -p <port>:7711 charlesportwoodii/<xenial|trusty|centos7|rhel7>:disque
```

### Nginx Mainline

NGINX is a free, open-source, high-performance HTTP server and reverse proxy (https://www.nginx.com/).

This docker image exposes port `80` and port `443`. Additionally the following directories are exposed:

```
/etc/nginx/conf/conf.d
/etc/nginx/conf/includes
/etc/nginx/conf/ssl
/var/www
```

A default server is created on port 80, however you should mount your own custom configurations into `/etc/nginx/conf/conf.d`

```bash
docker run  -p <port1>:80 \
            -p <port2>:443 \
            -v <conf.d_dir>:/etc/nginx/conf/conf.d \
            -v <includes_dir>:/etc/nginx/conf/includes \
            -v <ssl_dir>:/etc/nginx/conf/ssl \
            -v <webroot>:/var/www \
            charlesportwoodii/<xenial|trusty|centos7|rhel7>:nginx
```

By default, `/var/log/nginx/error.log` and `/var/log/nginx/access.log` is redirected to `/dev/stdout`.

### PHP

PHP is a popular general-purpose scripting language that is especially suited to web development. (https://www.php.net)

As I bundle PHP packages for multiple versions, please see the relevant sections below for more information. In general you can start a PHP docker image by running:

```bash
docker run  -p <port>:90(56|70|71)
            -v <php_working_dir>:/etc/php/(56|70|71)
            charlesportwoodii/<xenial|trusty|centos7|rhel7>:php(56|70|71)
```

By default FPM is listening on 90(56|70|71), where the last 2 numbers represent the major and minor version of the PHP version you wish to run. All FPM output (include PHP's slow log) will be redirected to `/dev/stdout`.

Additionally, the entirety of `/etc/php(56|70|71)` is available for mounting. If you have your own custom configuration you would like to load you may do so. In general the folder structure PHP FPM expects is listed below:

```bash
# Directories
./conf.d # PHP modules
./mods-available # Available modules that are not installed (such as Redis)
./php-fpm.d # The FPM pool directory

# Files
./php-fpm.conf # The main FPM configuration file
./php.ini # Your PHP ini file
```

#### 7.1

> 7.1 images are only available for `xenial`, `centos7`, and `rhel7`. `trusty` images are not provided.

#### 7.0

> 7.0 images are available for all available platforms

#### 5.6

> 5.6 images are available only for `xenial`, `centos7`, and `trusty`.  Please note that PHP 5.6 is only receiving security patches. I strongly advise to use a different version of PHP



