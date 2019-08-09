FROM php:7.2.14-fpm-alpine3.9
MAINTAINER Daniele Piaggesi <daniele.piaggesi@bmeme.com>
ENV REFRESHED_AT 2019-08-08

# Variables
ENV TIMEZONE "Europe/Rome"
ENV MCRYPT_VERSION "1.0.2"

# PHP environment variables.
ENV COMPOSER_HOME "/var/www/.composer"
ENV PHP_MEMORY_LIMIT "512M"
ENV PHP_ERROR_LOG "/tmp/php_errors.log"
ENV UPLOAD_MAX_FILESIZE "20M"
ENV POST_MAX_SIZE "20M"
ENV AUTO_PREPEND_FILE "${COMPOSER_HOME}/vendor/autoload.php"

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
                        ansible

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

# Install composer
RUN mkdir ${COMPOSER_HOME} && \
    curl -k -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    chown -R www-data:www-data ${COMPOSER_HOME}

# Add PHPINFO
COPY scripts/index.php /var/www/html/index.php

RUN chown -R www-data:www-data /var/www/html
