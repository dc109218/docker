#!/usr/bin/env bash

DFILE=1.Dockerfile
DUSER=dcsurani
DREPO=python
DTAG=$(date +'%d%m%y-%M%H%S')

docker build -f $DFILE . -t $DUSER/$DREPO:$DTAG --no-cache

docker stop hello
docker rm hello
docker run --name hello -p 11111:11111 -d $DUSER/$DREPO:$DTAG
