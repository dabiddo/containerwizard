FROM dunglas/frankenphp

# add additional extensions here:
RUN install-php-extensions \
    pdo_mysql \
    gd \
    intl \
    zip \
    opcache

#install composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN rm -rf composer-setup.php

# Changing Workdir
WORKDIR /app
