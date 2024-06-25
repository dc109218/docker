#!/bin/bash

echo "start\n"
set -e

CYN=$'\e[0;36m'
YLW=$'\e[0;33m'
BLE=$'\e[0;35m'
GRN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

DFILE='Dockerfile'
DOCKER_USR='dcsurani'
DOCKER_REPO='iwillbackend'
GBRANCH="$(git rev-parse --abbrev-ref HEAD)" # GBRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
TAG_DATE=$(date +'%d%m%y.%H%M%S')

#Create Dockerfile
cat << EOF > Dockerfile
# dockerfile create
FROM ubuntu:18.04

ENV TZ Asia/India
LABEL maintainer="Dinesh patel <md@sareteam.com>"

ENV DEBIAN_FRONTEND=noninteractive

# RUN apt-get update \
#     && apt-get install -y gnupg tzdata \
#     && echo "UTC" ? "/etc/timezone" \
#     && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update \
    && apt-get install -y curl zip unzip git supervisor \
       nginx php7.2-fpm php7.2-cli php7.2-curl \
       php7.2-mysql php7.2-mbstring php7.2-xml \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && mkdir /run/php \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

RUN rm -rf /etc/nginx/sites-available/*
COPY dcs/nginx.conf /etc/nginx/sites-available/default
COPY dcs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY dcs/initial.sh /usr/bin/initial
RUN chmod +x /usr/bin/initial

RUN rm -rf /var/www/html/*
COPY . /var/www/html

# EXPOSE 8090

ENTRYPOINT [ "initial" ]
EOF

echo "${CYN}$filename ${NC}is created"

#docker engine check on/off
if (! docker stats --no-stream ); then
    open /Applications/Docker.app
    # open -a Docker
  while (! docker stats --no-stream ); do
     echo "Waiting for Docker to launch..."
    sleep 1
  done
fi

docker build -f $DFILE . -t $DOCKER_USR/$DOCKER_REPO:$TAG_DATE --no-cache
echo "${CYN}Dockerize Build is ${NC}done..."

# sleep 1
if [ -f $DFILE ]; then
   rm $DFILE
   echo "$DFILE is removed"
fi

docker push $DOCKER_USR/$DOCKER_REPO:$TAG_DATE
echo "${BLE}Docker Hub ${YLW}Image ${NC}push done..."

#docker-close from app
# pkill -SIGHUP -f /Applications/Docker.app 'docker serve'
# echo "${RED}docker i sclosed${NC}"

echo "#$DOCKER_USR/$DOCKER_REPO:$TAG_DATE" >> run.sh

echo "${GRN}============================"
echo "${CYN}All ${YLW}Job ${GRN}Completed ${BLE}.........."
echo "${GRN}============================"

# =========#dcsurani/iwillbackend:030922.234436
