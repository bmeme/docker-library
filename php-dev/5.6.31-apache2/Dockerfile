FROM php:5.6.31-apache
MAINTAINER Daniele Piaggesi <daniele.piaggesi@bmeme.com>

ENV DEBIAN_FRONTEND noninteractive

# Enable apache rewrite.
RUN a2enmod rewrite

# System env variables.
ENV XDEBUG_VERSION 2.4.0
ENV DRUSH_VERSION 8.0.5
ENV VAR_DUMPER_VERSION 3.0.3
ENV GOSU_VERSION 1.7
ENV MAILHOG_VERSION v0.1.9
ENV TIMEZONE "Europe/Rome"

# Download basic packages
RUN apt-get update && apt-get install -y build-essential wget sendmail

# Download and add dotdeb packages
RUN echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list.d/dotdeb.list && \
	echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list.d/dotdeb.list && \
	wget -O- http://www.dotdeb.org/dotdeb.gpg | apt-key add -

# Download and add ansible PPA packages
RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list.d/ansible.list && \
      apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367

# Build stack
RUN apt-get update \
    && apt-get install -y libpng12-0 \
        libpng12-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        git \
        vim \
        zip \
        unzip \
        mysql-client \
        cron \
        rsyslog \
        supervisor \
        git \
        libpq-dev \
        zlib1g-dev \
        libicu-dev \
        g++ \
        graphviz \
        ansible \
        && dpkg-reconfigure -f noninteractive tzdata \
        && apt-get autoremove -y \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Install php libraries and configure PHP
RUN docker-php-ext-install pdo_mysql \
    && docker-php-ext-install -j$(nproc) json iconv mcrypt\
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install zip \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install sockets \
    && docker-php-ext-install intl \
    && pecl install xdebug-${XDEBUG_VERSION}

# Install composer and other stuff
ENV COMPOSER_HOME /composer-libs
RUN mkdir /composer-libs \
    && curl -k -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer global require symfony/var-dumper \
    && chown -R www-data:www-data /composer-libs \
    && curl -fSL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture)" -o /usr/bin/gosu \
    && curl -fSL "https://github.com/mailhog/MailHog/releases/download/${MAILHOG_VERSION}/MailHog_linux_amd64" -o /usr/local/bin/mailhog \
    && chmod +x /usr/local/bin/mailhog \
    && ansible-galaxy install carlosbuenosvinos.ansistrano-deploy carlosbuenosvinos.ansistrano-rollback

# Install Drush binary
RUN php -r "readfile('https://s3.amazonaws.com/files.drush.org/drush.phar');" > /tmp/drush \
    && php /tmp/drush core-status \
    && chmod +x /tmp/drush \
    && mv /tmp/drush /usr/local/bin/

# Configure PHP / Apache / Supervisord
COPY config/php/php.ini /usr/local/etc/php/php.ini
COPY config/php/conf.d/*.ini /usr/local/etc/php/conf.d/
RUN echo "date.timezone = \"UTC\"" >> /usr/local/etc/php/conf.d/timezone.ini
COPY config/apache2/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY config/supervisord/*.conf /etc/supervisor/conf.d/
RUN mkdir -p /usr/local/etc/php/apache2 && \
    cp -R /usr/local/etc/php/conf.d /usr/local/etc/php/apache2 && \
    echo 'export PHP_INI_SCAN_DIR=/usr/local/etc/php/apache2/conf.d' >> /etc/apache2/envvars

# Configure cron.
COPY config/cron/crontab /etc/cron.d/cron
RUN rm -Rf /etc/cron.daily  && \
    rm -Rf /etc/cron.weekly && \
    rm -Rf /etc/cron.monthly && \
    rm -Rf /etc/cron.hourly && \
    chmod a+x /etc/cron.d/cron

# Install blackfire agent.
RUN export VERSION=`php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;"` \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/${VERSION} \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so `php -r "echo ini_get('extension_dir');"`/blackfire.so \
    && echo "extension=blackfire.so\nblackfire.agent_socket=\${BLACKFIRE_PORT}" > $PHP_INI_DIR/apache2/conf.d/blackfire.ini

# Install ngrok.
ADD https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip /ngrok.zip
RUN unzip /ngrok.zip -d /bin && \
    rm -f ngrok.zip && \
    touch /.ngrok

# Create SSH structure
RUN mkdir /root/.ssh && chmod 700 /root/.ssh

# Expose apache.
EXPOSE 80

# Execute daemons.
CMD exec supervisord -n