# Example of docker-compose

## Usage

- Copy your PHP application into: `php-code` directory

- `$ docker-compose up -d`

- Navigate to [localhost:8080](http://localhost:8080)

You are browsing your PHP application using Bmeme docker image.

#### For use a edited local image

change these lines:

```
php-dev:
  image: bmeme/php-dev:7.0.24-fpm-nginx
```

with

```
php-dev:
  build: ../../php-dev/7.0.24-fpm-nginx
```
