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
    image: charlesportwoodii/php:7.1
    volumes:
      - ${PWD-.}:/var/www
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
      - ${PWD-.}:/var/www
      - ${PWD-.}/config/.docker/httpd:/etc/apache2/sites-enabled
      - ${PWD-.}/config/.docker/certs:/etc/apache2/conf/certs
  php:
    image: charlesportwoodii/php:7.1
    volumes:
      - ${PWD-.}:/var/www
```

### Complex Nginx, PHP 7.1, Redis, MariaDB, Mailhog server

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
    image: charlesportwoodii/php:7.1
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
