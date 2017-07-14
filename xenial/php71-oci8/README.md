# PHP 7.1 with OCI8 Driver

1. Download the Oracle Instant Client Library Basic and development RPM packages from http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html, and copy them to the ./build directory. Version 12.2.0.1.0 is required.

2. Build the docker container as normal.

3. After building the container run the following command inside it to enable the OCI8 driver

```
ln -s /usr/local/etc/php/7.1/mods-available/oci8.ini /etc/php/7.1/conf.d/oci8.ini
```