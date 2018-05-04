# Docker Compose Examples

These images can be used together to create complete docker environments

## Nginx + PHP

A simple Nginx + PHP FPM environment listening on port 80 and 443. Note that a `conf.d` environment is mounted as the Nginx image does not contain a default server.

```yaml
version: "3.3"
services:
  nginx:
    image: charlesportwoodii/nginx:mainline
    ports:
      - "80:80"
      - "443:443"
    links:
      - php:php
    volumes:
      - ${PWD-.}:/var/www
      - ${PWD-.}/config/.docker/nginx/conf.d:/etc/nginx/conf/conf.d
  php:
    image: charlesportwoodii/php:7.2
    volumes:
      - ${PWD-.}:/var/www
```

### Complex Nginx, PHP 7.2, Redis, MariaDB, Mailhog server

The following example is a more verbose LEMP environment with Nginx, PHP 7.1, Redis, MariaDB (MySQL), and Mailhog.

```yaml
version: "3.3"
services:
  nginx:
    image: charlesportwoodii/nginx:mainline
    ports:
      - "80:80"
      - "443:443"
    links:
      - php:php
    volumes:
      - ${PWD-.}:/var/www
      - ${PWD-.}/config/.docker/nginx/conf.d:/etc/nginx/conf/conf.d
  php:
    image: charlesportwoodii/php:7.2
    links:
      - redis:redis
      - mailhog:mailhog
      - mariadb:mariadb
      - disque:disque
    volumes:
      - ${PWD-.}:/var/www
  redis:
    image: redis
  mailhog: 
    image: mailhog/mailhog
    ports:
      - "1025:1025"
      - "8025:8025"
  mariadb:
    image: mariadb
    ports:
      - "3306:3306"
    environment:
      - MYSQL_ALLOW_EMPTY_PASSWORD=yes
      - MYSQL_ROOT_PASSWORD=root
      - MYSQL_DATABASE=root
      - MYSQL_USER=local
      - MYSQL_PASSWORD=local
```
