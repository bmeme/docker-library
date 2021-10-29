FROM php:7.3.28-apache-buster
ENV REFRESHED_AT 2021-06-01

LABEL mantainer='Daniele Piaggesi <daniele.piaggesi@bmeme.com>'

# Variables
ENV COMPOSER_HOME=/var/www/.composer \
    TIMEZONE=Europe/Rome

# Program version variables
ENV IGBINARY_VERSION=3.1.0 \
    MCRYPT_VERSION=1.0.3 \
    OAUTH_VERSION=2.0.4 \
    REDIS_VERSION=5.1.1

# PHP environment variables
ENV PHP_MEMORY_LIMIT=512M \
    PHP_MAX_EXECUTION_TIME=60 \
    PHP_LOG_ENABLED=1 \
    PHP_ERROR_LOG=/tmp/php_errors.log \
    PHP_UPLOAD_MAX_FILESIZE=20M \
    PHP_POST_MAX_SIZE=20M \
    PHP_SENDMAIL=/usr/local/sendmail

# OPCACHE environment variables
ENV OPCACHE_ENABLED=1 \
    OPCACHE_MEMORY_CONSUMPTION=128 \
    OPCACHE_INTERNED_STRINGS_BUFFER=8 \
    OPCACHE_MAX_ACCELERATED_FILES=4000 \
    OPCACHE_REVALIDATE_FREQ=60 \
    OPCACHE_FAST_SHUTDOWN=1

ENV PERSISTENT_PROGRAMS \
    git \
    default-mysql-client \
    patch \
    python3 \
    python3-distutils \
    tzdata \
    unzip \
    vim \
    zip

# install the PHP extensions we need
RUN set -eux; \
	\
	if command -v a2enmod; then \
		a2enmod rewrite; \
	fi; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	\
	apt-get update; \
	apt-get install -y --no-install-recommends \
        ${PHPIZE_DEPS} \
        ${PERSISTENT_PROGRAMS} \
        libfreetype6-dev \
        libicu-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpcre3-dev \
        libpng-dev \
        libpq-dev \
        libzip-dev \
	; \
	\
	pecl install \
	    mcrypt-${MCRYPT_VERSION} \
	    igbinary-${IGBINARY_VERSION} \
	    oauth-${OAUTH_VERSION} \
	; \
	\
	# See https://github.com/phpredis/phpredis/issues/1176#issuecomment-558787347
	pecl bundle --destination=/usr/src/php/ext redis-${REDIS_VERSION}; \
	\
	docker-php-ext-configure gd \
		--with-freetype-dir=/usr \
		--with-jpeg-dir=/usr \
		--with-png-dir=/usr \
	; \
	docker-php-ext-configure intl; \
	docker-php-ext-configure zip \
	    --with-libzip; \
	docker-php-ext-configure redis \
	    --enable-redis-igbinary \
	    --enable-redis-lzf \
	;\
	\
	docker-php-ext-enable \
	    mcrypt \
	    igbinary \
	    oauth \
	; \
	\
	docker-php-ext-install -j "$(nproc)" \
		bcmath \
		gd \
		intl \
		opcache \
		pdo_mysql \
		pdo_pgsql \
		redis \
		sockets \
		zip \
	; \
	\
    # install composer
    mkdir ${COMPOSER_HOME}; \
    curl -k -sS https://getcomposer.org/installer \
        | php -- --install-dir=/usr/local/bin --filename=composer; \
    # install ansible
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py; \
    python3 get-pip.py; \
    pip install ansible; \
    # reset apt-mark's "manual" list so that "purge --auto-remove" will remove all build dependencies
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual ${savedAptMark}; \
	ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
		| awk '/=>/ { print $3 }' \
		| sort -u \
		| xargs -r dpkg-query -S \
		| cut -d: -f1 \
		| sort -u \
		| xargs -rt apt-mark manual; \
	\
    apt-mark manual ${PERSISTENT_PROGRAMS}; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*; \
	\
    # remove php source
    docker-php-source delete

RUN set -eux; \
	# set localtime and timezone
	rm /etc/localtime; \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime; \
    echo "${TIMEZONE}" > /etc/timezone; \
    \
    # set application ini settings
    { \
        echo 'date.timezone = ${TIMEZONE}'; \
        echo 'error_log = ${PHP_ERROR_LOG}'; \
        echo 'log_errors = ${PHP_LOG_ENABLED}'; \
        echo 'max_execution_time = ${PHP_MAX_EXECUTION_TIME}'; \
        echo 'memory_limit = ${PHP_MEMORY_LIMIT}'; \
        echo 'post_max_size = ${PHP_POST_MAX_SIZE}'; \
        echo 'sendmail_path = ${PHP_SENDMAIL}'; \
        echo 'upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}'; \
	} > /usr/local/etc/php/conf.d/application.ini; \
	\
    # set opcache ini settings
    # see https://secure.php.net/manual/en/opcache.installation.php
    { \
		echo 'opcache.enable = ${OPCACHE_ENABLED}'; \
		echo 'opcache.memory_consumption = ${OPCACHE_MEMORY_CONSUMPTION}'; \
		echo 'opcache.interned_strings_buffer = ${OPCACHE_INTERNED_STRINGS_BUFFER}'; \
		echo 'opcache.max_accelerated_files = ${OPCACHE_MAX_ACCELERATED_FILES}'; \
		echo 'opcache.revalidate_freq = ${OPCACHE_REVALIDATE_FREQ}'; \
		echo 'opcache.fast_shutdown = ${OPCACHE_FAST_SHUTDOWN}'; \
	} > /usr/local/etc/php/conf.d/opcache.ini; \
	\
	# inject index.php
	echo '<?php phpinfo();' > /var/www/html/index.php
