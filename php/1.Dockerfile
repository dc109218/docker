FROM ubuntu:18.04

ENV TZ=IST

USER root

RUN apt-get update -y && apt -y install wget lsb-release apt-transport-https ca-certificates 
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg

RUN apt-get install -y php7.4
RUN apt-get install -y php7.4-fpm php7.4-cli php7.4-mysql
RUN apt-get install -y php7.4-curl php7.4-json nginx

RUN service php7.4-fpm start \
    && service php7.4-fpm enable

RUN rm -rf  /var/www/html/*
WORKDIR /var/www/html 
COPY . /var/www/html
RUN rm -rf /etc/nginx/sites-available/default
ADD nginx.conf /etc/nginx/sites-available/default

RUN systemctl restart nginx

CMD ["nginx", "-g", "daemon off"]
