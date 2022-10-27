FROM php:8.0-fpm
WORKDIR /app/
RUN apt-get update
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN apt-get install libzip-dev zip libicu-dev libpq-dev -y
RUN docker-php-ext-install zip && docker-php-ext-configure intl && docker-php-ext-install intl
RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && docker-php-ext-install pdo_pgsql pgsql
COPY . ./
RUN composer install --ignore-platform-reqs
RUN php artisan key:generate
