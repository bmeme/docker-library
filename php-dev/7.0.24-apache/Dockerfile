FROM php:7.0.24-apache
MAINTAINER Daniele Piaggesi <daniele.piaggesi@bmeme.com>
ENV REFRESHED_AT 2018-08-02

# Variables
ENV XDEBUG_VERSION "2.5.5"
ENV TIMEZONE "Europe/Rome"
ENV MHSENDMAIL_VERSION "v0.2.0"
ENV COMPOSER_HOME "/root/.composer"

# Download all packages
RUN apt-get update && \
    apt-get install -y build-essential \
                        wget \
                        libpcre3-dev \
                        libpng12-0 \
                        libpng12-dev \
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
                        g++ \
                        graphviz \
                        ansible && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install php libraries and configure PHP
RUN docker-php-ext-install pdo_mysql && \
    docker-php-ext-install -j$(nproc) json iconv && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-install zip && \
    docker-php-ext-install bcmath && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install mcrypt && \
    docker-php-ext-install sockets && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl && \
    pecl install xdebug-${XDEBUG_VERSION} && \
    pecl install oauth && \
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

COPY scripts/start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80 443 9001

CMD ["/start.sh"]
