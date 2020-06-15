FROM alpine:latest

RUN mkdir -p /var/www/html/

COPY .env /var/www/html/.env

COPY ./config/ /var/www/html/config/