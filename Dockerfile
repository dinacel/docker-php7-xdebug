FROM php:7.3-cli

MAINTAINER Dinacel admin@dinacel.com

# Install required system packages
RUN apt-get update && \
    apt-get -y install \
            curl \
            git \
            imagemagick \
            libmagickwand-dev \
            libicu-dev \
            zlib1g-dev \
            libssl-dev \
            libzip-dev \
            unzip \
        --no-install-recommends && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install php extensions
RUN docker-php-ext-install \
    bcmath \
    intl \
    zip
    
# Install pecl extensions
RUN pecl install xdebug-2.7.0RC2 \
        apcu-5.1.17 \
        imagick-3.4.3 \
    && docker-php-ext-enable xdebug \
        apcu \
        imagick

# Configure php
RUN echo "date.timezone = Europe/Paris" >> /usr/local/etc/php/php.ini

# Prepare host-volume working directory
RUN mkdir /project
WORKDIR /project
