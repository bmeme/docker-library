FROM php:7.2.11-fpm-alpine3.8
LABEL maintainer "daniele.piaggesi@bonsaimeme.com"
ENV REFRESHED_AT 2018-11-07

# Variables
ENV TIMEZONE "Europe/Rome"
ENV MCRYPT_VERSION "1.0.1"

# PHP environment variables.
ENV COMPOSER_HOME "/var/www/.composer"
ENV PHP_MEMORY_LIMIT "512M"
ENV PHP_ERROR_LOG "/tmp/php_errors.log"
ENV UPLOAD_MAX_FILESIZE "20M"
ENV POST_MAX_SIZE "20M"
ENV AUTO_PREPEND_FILE "${COMPOSER_HOME}/vendor/autoload.php"

# Download all packages
RUN apk add --update \
            $PHPIZE_DEPS \
            libpng \
            libpng-dev \
            freetype \
            freetype-dev \
            libjpeg \
            libjpeg-turbo-dev \
            tzdata \
            mysql-client && \
    rm -rf /var/cache/apk/*

# Install PHP libraries and configure PHP
RUN pecl install mcrypt-${MCRYPT_VERSION} && \
    pecl install oauth && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install -j$(nproc) json iconv && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-install zip && \
    docker-php-ext-install bcmath && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install sockets && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl && \
    docker-php-ext-enable mcrypt && \
    rm /etc/localtime && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    curl -k -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    mv /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

# Copy custom ini file
COPY config/php/prod.ini /usr/local/etc/php/conf.d/

# Add PHPINFO
COPY scripts/index.php /var/www/html/index.php