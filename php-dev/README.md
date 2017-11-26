### Overview
These are Docker images based on Debian/Jessie with a working webserver, ready to be used for php development. They are all built starting from [official PHP repository](https://hub.docker.com/_/php/) as you can see looking our Dockerfile (see previous paragraph).

### Supported tags and respective `Dockerfile` links
- `7.0.24-fpm-nginx`, `7.0`, `7.0-fpm-nginx` or `latest` [Dockerfile](https://github.com/bmeme/docker-library/blob/master/php-dev/7.0.24-fpm-nginx/Dockerfile)
- `7.0.24-apache`, `7.0-apache` [Dockerfile](https://github.com/bmeme/docker-library/blob/master/php-dev/7.0.24-apache/Dockerfile) 
- `5.6.31-apache2`, `5.6`, `5.6-apache`[Dockerfile] (https://github.com/bmeme/docker-library/blob/master/php-dev/5.6.31-apache2/Dockerfile)

### Packages contained in all images
- DotDeb APT repositories, stored in `/etc/apt/sources.d`
- Some useful executables like: `wget`, `git`, `vim`, `zip` and `unzip`, `cron` with basic configuration, `rsyslog` to manage system logging, `mysql-client`, `ansible`.
- `supervisord`explained later
- The following php libraries (installed using `docker-php-ext-configure`/`docker-php-ext-install`): 
-- `bcmath`
-- `pdo_mysql`
-- `json`
-- `iconv`
-- `mcrypt`
-- `gd`
-- `zip`
-- `mbstring`
-- `mcrypt`
-- `sockets`
-- `intl`
-- `oauth`
- Composer package manager
- Xdebug as debug tool
- Blackfire php extension as profiler tool, usable in conjunction with [blackfire image](https://hub.docker.com/r/blackfire/blackfire/) (see documentation for examples)
- Symfony var-dumper packages installed by composer
- Mailhog package usable in conjunction with [mailhog image](https://hub.docker.com/r/mailhog/mailhog/) via `sendmail`
- Ngrok to create secure tunnels to your container, very useful for some specific activites just like crossbrowser/crossdevice compatibility

### How to use this image
## Manually
Starting your PHP environment is really simple:
`$ docker run --name some-name -p 8080:80 -d bmeme/php-dev:tag`
where `some-name` is the name you want to assign to your container and `tag` is the tag specifying the image version you want. See the list above for relevant tags. Pointing your browser to `http://localhost:8080` you'll see the complete `phpinfo`.
Obviously you can change the local binding port matching your needs.

## Using a Dockerfile
`FROM php-dev:7.0.24-fpm-nginx`
`COPY src/ /var/www/html/`
Where src/ is the directory containing all your PHP code. 
Then, run the commands to build and run the Docker image:
`$ docker build -t my-php-dev-app .`
`$ docker run -d --name my-running-app my-php-dev-app`

If you want to customise PHP settings look at the following paragraph before to `COPY` a `php.ini` file into the container during the build process.

### Custom Environments
- `PHP_MEMORY_LIMIT`, default at 512M
- `PHP_ERROR_LOG`, default at `/tmp/php_errors.log`
- `UPLOAD_MAX_FILESIZE`, default at `20M`
- `POST_MAX_SIZE` default at `20M`

## With a database image
`$ docker run --name some-name --link some-db-image:some-tag -d bmeme/php-dev:tag`
Follow instructions in database image repository to correctly match available environments.

## Via `docker-compose`
```
version: '3.1'
services:
  php-dev:
    image: php-dev:7.0.24-fpm-nginx
    ports:
      - 8080:80
      - 8443:443
      - 9001:9001 # xdebug port
    environment: # just as example
      - UPLOAD_MAX_FILESIZE=100M
      - POST_MAX_SIZE=100M
    restart: always
  postgres:
    image: postgres:9.6
    environment:
      - POSTGRES_PASSWORD: example
    restart: always
```

Run `docker-compose -f php-dev.yml up`, wait for it to initialize completely, and visit `http://localhost:8080`, or `http://host-ip:8080` (as appropriate).

### Image Variants
The `php-dev` images come basically in two "main" flavour:
- `php-fpm` engine with `nginx` embedded
- php module engine with `apache2` embedded

### Supervisord
This image is using `supervisor` to start at the same time:
- php-fpm if shipped
- apache2 or nginx
- rsyslog
- cron

### Documentation
To Be Done.

### Credits
This project is a contribution of [Bmeme :: The Digital Factory](http://www.bmeme.com).
This library is actually maintained by [Daniele Piaggesi](mailto:daniele.piaggesi@bmeme.com). 
Really thanks to [Francesco Pesenti](mailto:francesco.pesenti@psegno.it) aka `Pex` of [Psegno](http://www.psegno.it) for 5.6.x image and some other fixes and tests.
Any other contribution will be really appreciated.
