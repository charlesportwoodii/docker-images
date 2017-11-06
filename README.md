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

## Example Compose Files

See the [EXAMPLES.md](EXAMPLES.md) directory for `docker-compose.yml` examples for how to use these images together.

## Software Images

In addition to the `base` and `build` images, the following extra images are provided to showcase the packages that are built on TravisCI.

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
            charlesportwoodii/<xenial>:nginx
```

By default, `/var/log/nginx/error.log` and `/var/log/nginx/access.log` is redirected to `/dev/stdout`.

### Apache

Apache2 is free and open-source, cross-platform web server software.

This docker image exposes port `80` and port `443`. Additionally the following directories are exposed:

```
/etc/apache2/sites-enabled
/etc/apache2/conf/certs
/var/www
```

A default server is created on port 80, however you should mount your own custom configurations into `/etc/nginx/conf/conf.d`

```bash
docker run  -p <port1>:80 \
            -p <port2>:443 \
            -v <conf.d_dir>:/etc/apache2/sites-enabled \
            -v <ssl_dir>:/etc/apache2/conf/certsl \
            -v <webroot>:/var/www \
            charlesportwoodii/<xenial>:nginx
```

### PHP

PHP is a popular general-purpose scripting language that is especially suited to web development. (https://www.php.net)

As I bundle PHP packages for multiple versions, please see the relevant sections below for more information. In general you can start a PHP docker image by running:

```bash
docker run  -p <port>:90(70|71|72)
            -v <php_working_dir>:/etc/php/(7.0|7.1|7.2)
            charlesportwoodii/php:(7.0|7.1|7.2)
```

By default FPM is listening on 90(70|71|72), where the last 2 numbers represent the major and minor version of the PHP version you wish to run. All FPM output (include PHP's slow log) will be redirected to `/dev/stdout`.

Additionally, the entirety of `/etc/php(7.0|7.1|7.2)` is available for mounting. If you have your own custom configuration you would like to load you may do so. In general the folder structure PHP FPM expects is listed below:

```bash
# Directories
./conf.d # PHP modules
./mods-available # Available modules that are not installed (such as Redis)
./php-fpm.d # The FPM pool directory

# Files
./php-fpm.conf # The main FPM configuration file
./php.ini # Your PHP ini file
```

> Note that packages are provided for `Alpine` and `Xenial`.



