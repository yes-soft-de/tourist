# Get the config
FROM gcr.io/tourists-280412/tourists-config:latest as tourists_config

# Get Composer
FROM composer:latest AS composer

# Build it
FROM php:fpm-alpine3.12 as builder
WORKDIR /var/www/html/
# Get the Config, for Composer to work!
COPY --from=tourists_config /var/www/html/ /var/www/html/
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Add the project
COPY . . 
RUN composer install

# Serve it
FROM alpine:latest
WORKDIR /var/www/html
COPY --from=builder /var/www/html/ /var/www/html/