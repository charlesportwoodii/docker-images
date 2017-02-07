# Docker Images for TravisCI Builds

[![TravisCI](https://img.shields.io/travis/charlesportwoodii/docker-images.svg?style=flat-square&branch=master "TravisCI")](https://travis-ci.org/charlesportwoodii/docker-images)
[![License](https://img.shields.io/badge/license-BSD-orange.svg?style=flat-square "License")](https://github.com/charlesportwoodii/docker-images/blob/master/LICENSE.md)

## Introduction

For transparency purposes (and to reduce build time), I build all of my deb and rpm packages on TravisCI, then push them to deb.erianna.com and rpm.erianna.com, respectively. To ensure compatability with each OS that I build packages for, all packages are built on a docker container of the OS the package is built for.

The purpose of these boxes is primarily to ensure compatability with the OS packages are built for, and to reduce build times in Travis CI. These images are automatically pushed to DockerHub after they are built. 

## Supported Images

A full list of images that TravisCI builds is listed below. The created images will always be available on [DockerHub](https://hub.docker.com/r/charlesportwoodii/docker-images/tags/)

- Ubuntu 14.04 (trusty)
- Ubuntu 16.04 (xenial)
- CentOS 7
- RHEL 7*

> *RHEL7 builds are built against RedHat provided developer images. The built images is intended solely for the building of packages and for no other purpose. The image is _not_ registered or subscribed. If you wish to use the RHEL7 image you must subscribe it using your own developer credentials.
