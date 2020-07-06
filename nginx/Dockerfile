# Grab the final Product
FROM gcr.io/tourists-280412/server-container:latest AS symfony

RUN ls /var/www/html/

# Copy it and serve it
FROM nginx:latest
WORKDIR /var/tourists
RUN mkdir -p /var/tourists
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=symfony /var/www/html /var/tourists

RUN rm -rf /var/tourists/var

COPY ./start-point.sh /usr/local/bin/start-point
RUN chmod 755 /usr/local/bin/start-point

RUN ls /usr/local/bin/

# CMD ["start-point"]