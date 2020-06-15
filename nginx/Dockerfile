# Grab the final Product
FROM gcr.io/tourists-280412/server-container:latest AS symfony

RUN ls /var/www/html/

# Copy it and serve it
FROM nginx:latest
RUN mkdir -p /var/www/html
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=symfony /var/www/html /var/www/html
RUN cat /var/www/html/public/index.php