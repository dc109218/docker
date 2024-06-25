#!/bin/bash

set -e

DREPO="dcsurani/iwillbackend:040922.110920"

# docker build -t iwill -f 1.Dockerfile .

docker stop hello && docker rm hello

# docker run --name hello -d -p 80:80 -p 8080:80 iwill
docker run --name hello -d -p 80:80 $DREPO