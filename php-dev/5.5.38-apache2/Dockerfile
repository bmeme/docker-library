FROM php:5.5.38-apache
MAINTAINER Daniele Piaggesi <daniele.piaggesi@bmeme.com>
ENV REFRESHED_AT 2019-05-24

# Variables
ENV XDEBUG_VERSION "2.5.5"
ENV TIMEZONE "Europe/Rome"
ENV MAILHOG_VERSION "v1.0.0"
ENV MHSENDMAIL_VERSION "v0.2.0"

# PHP environment variables.
ENV COMPOSER_HOME "/var/www/.composer"
ENV PHP_MEMORY_LIMIT "512M"
ENV PHP_ERROR_LOG "/tmp/php_errors.log"
ENV UPLOAD_MAX_FILESIZE "20M"
ENV POST_MAX_SIZE "20M"
ENV AUTO_PREPEND_FILE "${COMPOSER_HOME}/vendor/autoload.php"
ENV XDEBUG_IDEKEY "PHPSTORM"

# This solves 404 Error in AWS apg-get for debian jessie fetch
RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list

# Install basic packages
RUN apt-get update && apt-get install -y build-essential \
                        wget \
                        libpcre3-dev \
                        libpng12-0 \
                        libpng12-dev \
                        libjpeg62-turbo-dev \
                        libfreetype6-dev \
                        mcrypt \
                        libmcrypt-dev \
                        git \
                        vim \
                        zip \
                        unzip \
                        mysql-client \
                        cron \
                        rsyslog \
                        supervisor \
                        libpq-dev \
                        zlib1g-dev \
                        libicu-dev \
                        g++ \
                        graphviz \
                        gnupg && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Ansible via PIP.
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python get-pip.py && \
    pip install ansible

# Install php libraries and configure PHP
RUN docker-php-ext-install pdo_mysql && \
    docker-php-ext-install -j$(nproc) json iconv && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-install zip && \
    docker-php-ext-install bcmath && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install sockets && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl && \
    pecl install xdebug-${XDEBUG_VERSION} && \
    rm /etc/localtime && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone

# Install composer and require symfony/var-dumper globally
RUN mkdir ${COMPOSER_HOME} && \
    curl -k -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require symfony/var-dumper && \
    chown -R www-data:www-data ${COMPOSER_HOME}

# Configure php.
COPY config/php/dev.ini /usr/local/etc/php/conf.d/

# Configure Apache2
COPY config/apache2/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# Configure supervisord
RUN mkdir -p /var/log/supervisor
ADD config/supervisor/supervisord.conf /etc/supervisord.conf

# Configure crontab.
COPY config/cron/crontab /etc/cron.d/crontab

# Add PHPINFO
COPY scripts/index.php /var/www/html/index.php

# Add start script
COPY scripts/start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80 443 9001

CMD ["/start.sh"]


