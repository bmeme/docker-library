FROM php:7.2.14-fpm
MAINTAINER Daniele Piaggesi <daniele.piaggesi@bmeme.com>
ENV REFRESHED_AT 2018-08-01

# Variables
ENV XDEBUG_VERSION "2.6.0"
ENV TIMEZONE "Europe/Rome"
ENV MCRYPT_VERSION "1.0.1"
ENV MHSENDMAIL_VERSION "v0.2.0"

# PHP environment variables.
ENV COMPOSER_HOME "/var/www/.composer"
ENV PHP_MEMORY_LIMIT "512M"
ENV PHP_ERROR_LOG "/tmp/php_errors.log"
ENV UPLOAD_MAX_FILESIZE "20M"
ENV POST_MAX_SIZE "20M"
ENV AUTO_PREPEND_FILE "${COMPOSER_HOME}/vendor/autoload.php"
ENV XDEBUG_IDEKEY "PHPSTORM"

# Download all packages
RUN apt-get update && \
    apt-get install -y build-essential \
                        wget \
                        libpcre3-dev \
                        libpng16-16 \
                        libpng-dev \
                        libfreetype6-dev \
                        libjpeg62-turbo-dev \
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
                        nginx \
                        g++ \
                        graphviz \
			            gnupg \
                        python-pip && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
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
    pecl install mcrypt-${MCRYPT_VERSION} && \
    pecl install oauth && \
    pecl install igbinary && \
    pecl install redis && \
    docker-php-ext-enable mcrypt && \
    rm /etc/localtime && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone

# Install composer and require symfony/var-dumper globally
RUN mkdir ${COMPOSER_HOME} && \
    curl -k -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require symfony/var-dumper && \
    chown -R www-data:www-data ${COMPOSER_HOME}

# Install mhsendmail
# @see https://www.lullabot.com/articles/debugging-php-email-with-mailhog
RUN wget https://github.com/mailhog/mhsendmail/releases/download/${MHSENDMAIL_VERSION}/mhsendmail_linux_amd64 && \
    chmod +x mhsendmail_linux_amd64 && \
    mv mhsendmail_linux_amd64 /usr/local/bin/mhsendmail

# Configure php.
COPY config/php/dev.ini /usr/local/etc/php/conf.d/
# This enable php-fpm working with environment variables
# @see https://ypereirareis.github.io/blog/2015/12/13/symfony-nginx-environment-variables-php-fpm/
RUN echo "clear_env = no" >> /usr/local/etc/php-fpm.d/www.conf

# Configure Nginx
COPY config/nginx/default.conf /etc/nginx/sites-available/default

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
