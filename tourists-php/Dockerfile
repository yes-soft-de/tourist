FROM php:fpm-alpine3.12

RUN apk update \
    && apk add autoconf php7-mysqli php7-mbstring \
    && docker-php-ext-install mysqli pdo_mysql \
    && rm /var/cache/apk/*

EXPOSE 9000