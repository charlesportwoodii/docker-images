# Docker Compose Examples

These images can be used together to create complete docker environments

## Nginx + PHP

A simple Nginx + PHP FPM environment listening on port 80 and 443. Note that a `conf.d` environment is mounted as the Nginx image does not contain a default server.

```yaml
version: "3.3"
services:
  nginx:
    image: charlesportwoodii/xenial:nginx
    ports:
      - "80:80"
      - "443:443"
    links:
      - php:php
    volumes:
      - ./:/var/www
      - ./config/.docker/nginx/conf.d:/etc/nginx/conf/conf.d
  php:
    image: charlesportwoodii/xenial:php71
    ports:
      - "9071:9071"
      - "9000:9000"
    volumes:
      - ./:/var/www
```

## Apache + PHP

A simple Apache2 + PHP environment listening on port 80, 443.

> note that the `httpd` and `certs` directory are provided by the host, as the default image does not contain an `<VirtualHost>` block.

```yaml
version: "3.3"
services:
  apache2:
    image: charlesportwoodii/xenial:apache2
    ports:
      - "80:80"
      - "443:443"
    links:
      - php:php
    volumes:
      - ./:/var/www
      - ./config/.docker/httpd:/etc/apache2/sites-enabled
      - ./config/.docker/certs:/etc/apache2/conf/certs
  php:
    image: charlesportwoodii/xenial:php71
    ports:
      - "9071:9071"
      - "9000:9000"
    volumes:
      - ./:/var/www
```

### Complex Nginx, PHP 7.1, Redis, MariaDB, Disque, Mailhog server

The following example is a more verbose LEMP environment with Nginx, PHP 7.1, Redis, MariaDB (MySQL), Disque, and Mailhog.

```yaml
version: "3.3"
services:
  nginx:
    image: charlesportwoodii/xenial:nginx
    ports:
      - "80:80"
      - "443:443"
    links:
      - php:php
    volumes:
      - ./:/var/www
      - ./config/.docker/nginx/conf.d:/etc/nginx/conf/conf.d
  php:
    image: charlesportwoodii/xenial:php71
    ports:
      - "9071:9071"
      - "9000:9000"
    links:
      - redis:redis
      - mailhog:mailhog
      - mariadb:mariadb
      - disque:disque
    volumes:
      - ./:/var/www
  redis:
    image: redis
    ports:
      - "6379:6379"
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
  disque:
    image: charlesportwoodii/xenial:disque
    ports:
      - "7711:7711"
```