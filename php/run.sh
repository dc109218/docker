#!/bin/bash

set -e

docker build -t iwill -f 2.Dockerfile .

docker stop hello && docker rm hello

# docker run --name hello -d -p 80:80 -p 8080:80 iwill
docker run --name hello -d -p 80:80 iwill