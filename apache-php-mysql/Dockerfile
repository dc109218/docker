FROM httpd:2.4.33-alpine

RUN apk update; \
    apk upgrade;

# Copy apache vhost file to proxy php requests to php-fpm container
COPY demo.apache.conf /usr/local/apache2/conf/demo.apache.conf
RUN echo "Include /usr/local/apache2/conf/demo.apache.conf" \
    >> /usr/local/apache2/conf/httpd.conf

# php/Dockerfile
FROM php:7.2.7-fpm-alpine3.7
RUN apk update; \
    apk upgrade;
RUN docker-php-ext-install mysqli