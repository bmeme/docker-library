FROM php:7.2.14-fpm-alpine3.9
MAINTAINER Daniele Piaggesi <daniele.piaggesi@bmeme.com>
ENV REFRESHED_AT 2019-08-08

# Variables
ENV TIMEZONE "Europe/Rome"
ENV MCRYPT_VERSION "1.0.2"
ENV MHSENDMAIL_VERSION "v0.2.0"

# PHP environment variables.
ENV COMPOSER_HOME "/var/www/.composer"
ENV PHP_MEMORY_LIMIT "512M"
ENV PHP_MAX_EXECUTION_TIME "30"
ENV PHP_LOG_ENABLED 1
ENV PHP_ERROR_LOG "/tmp/php_errors.log"
ENV PHP_UPLOAD_MAX_FILESIZE "20M"
ENV PHP_POST_MAX_SIZE "20M"
ENV PHP_SENDMAIL "/usr/local/sendmail"
ENV PHP_OPCACHE_ENABLED 0

# Download all packages
RUN apk add --no-cache $PHPIZE_DEPS \
                        vim \
                        zip \
                        unzip \
                        libjpeg-turbo-dev \
                        libpng-dev \
                        freetype-dev \
                        libmcrypt-dev \
                        libzip-dev \
                        icu-dev \
                        pcre-dev \
                        patch \
                        tzdata \
                        g++ \
                        ansible \
                        git \
                        mysql-client

# Install php libraries and configure PHP
RUN docker-php-ext-install pdo_mysql && \
    docker-php-ext-install -j$(nproc) json iconv && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-install zip && \
    docker-php-ext-install bcmath && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install sockets && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl && \
    docker-php-ext-install opcache && \
    pecl install mcrypt-${MCRYPT_VERSION} && \
    pecl install oauth && \
    pecl install igbinary && \
    pecl install redis && \
    docker-php-ext-enable mcrypt && \
    rm /etc/localtime && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone

# Install composer and set correct permissions
RUN mkdir ${COMPOSER_HOME} && \
    curl -k -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add Scripts
COPY config/application.ini /usr/local/etc/php/conf.d/
COPY scripts/index.php /var/www/html/index.php
