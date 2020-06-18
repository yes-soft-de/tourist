FROM alpine:latest

RUN mkdir -p /var/www/html/

COPY .env.prod /var/www/html/.env

COPY ./config/ /var/www/html/config/