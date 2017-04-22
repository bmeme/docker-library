FROM php:7.0.18-fpm
MAINTAINER Daniele Piaggesi <daniele.piaggesi@bmeme.com>

# Download basic packages
RUN apt-get update && apt-get install -y build-essential wget

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
        sendmail \
        ansible \
        nginx

# Install php libraries
RUN docker-php-ext-install pdo_mysql \
    && docker-php-ext-install -j$(nproc) json iconv mcrypt\
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install zip

# Create SSH structure
RUN mkdir /root/.ssh && chmod 700 /root/.ssh

# Configure php.
COPY config/php/php.ini /usr/local/etc/php/php.ini

# Configure Nginx
COPY config/nginx/default.conf /etc/nginx/sites-available/default

# Install Ansistrano
RUN ansible-galaxy install carlosbuenosvinos.ansistrano-deploy carlosbuenosvinos.ansistrano-rollback

# Install composer binary
RUN curl -k -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Drush binary
RUN php -r "readfile('https://s3.amazonaws.com/files.drush.org/drush.phar');" > /tmp/drush \
    && php /tmp/drush core-status \
    && chmod +x /tmp/drush \
    && mv /tmp/drush /usr/local/bin/
