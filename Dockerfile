FROM php:7.3-fpm

LABEL maintainer="Lakshmi Narasimhan <lakshmi@shapeblock.com>"

RUN apt-get update \
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev libzip-dev wget git curl python unzip mariadb-client

RUN  docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
     && docker-php-ext-install gd \
     && :\
     && docker-php-ext-install pdo pdo_mysql opcache zip bcmath \
     && docker-php-ext-enable pdo pdo_mysql opcache zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer global require hirak/prestissimo

# create user
RUN useradd -u 1001 -r -g 0 -d /app -s /bin/bash -c "Default Application User" default \
    && mkdir -p /app \
    && chown -R 1001:0 /app && chmod -R g+rwX /app

# copy code
COPY . /app

USER 1001

WORKDIR /app

# run composer
RUN COMPOSER_HOME=/app/composer-cache composer install --no-dev --prefer-dist --no-interaction --no-ansi --optimize-autoloader
