#!/bin/bash

set -e

# DREPO="dcsurani/iwillfrontend:040922.094114"
# DREPO="dcsurani/iwillfrontend:040922.103957"
DREPO=dcsurani/iwillfrontend:040922.112244

# docker build -t iwill -f 1.Dockerfile .

docker stop hello && docker rm hello

# docker run --name hello -d -p 80:80 -p 8080:80 iwill
docker run --name hello -d $DREPO