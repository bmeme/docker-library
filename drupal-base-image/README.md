# Drupal8-base-image

## Overview

The images contained in this project are built on top at the official 
php-fpm Debian-based images and are ready to host a Drupal8 instance.

By default, they contain:

- Dotdeb packages (http://packages.dotdeb.org) correctly installed and 
available in `/etc/apt/sources.list.d`.
- A set of important packages such as: git, zip, mysql-client, sendmail, 
libpng* and others 
- Docker php extensions: mysql, gd, zip, json, iconv, mcrypt
- A preconfigured `php.ini` with 512M of memory_limit and the sendmail 
path correctly configured (to avoid errors, to know more 
see: http://axiac.ro/blog/sh-1-t-not-found/)
- Composer
- Drush

**IMPORTANT:** These images are **NOT** ready for production. 
If you need to use one of them for your live environment, please fork 
the project and customize the image you want, before use it.

## Webservers
All of these images contain also a working webserver: Nginx or Apache Httpd.
In Bmeme we prefer to use Nginx for all our development and production
environments. But in "real world" Apache Httpd is still widely used.
 
## What is NOT contained
These images do not contain:

- A database server (mysql/mariadb/percona or postgresql)
- A cache server (Memcache or Redis)
- A proxy-cacher (Varnish)

This because they are born, basically, to have a small and functional 
drupal8 environment. 

## Status Update
At the moment, there is only a working image (7.0.17-fpm-nginx) composed by:

- PHP 7.0.17-fpm
- Nginx 1.10.x

Our idea is to add soon:

- 7.0.17-fpm-apache
- 5.6.x-fpm-nging
- 5.6.x-fpm-apache
- 7.1.x-fpm-apache
- 7.0.17-fpm-nginx

## Maintenance

These images are maintained by Bmeme, especially by Daniele Piaggesi
<daniele.piaggesi@bmeme.com>.
Any contributions will be really appreciated.