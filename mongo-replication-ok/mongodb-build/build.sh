#!/bin/bash

set -e

DTAG="5.0.15-focal"
DUSER="registry.roleit.com:5443"
DREPO="mongo"

#docker engine check on/off
if (! docker stats --no-stream ); then
    # open /Applications/Docker.app
    # "C:\Program Files\Docker\Docker\Docker Desktop.exe" &
    open --background -a Docker
    echo "open docker done"
  while (! docker stats --no-stream ); do
     echo "Waiting for Docker to launch..."
    sleep 1
  done
fi

# openssl rand -base64 756 > $PWD/auth/mongodb-keyfile

docker build -t $DUSER/$DREPO:$DTAG -f Dockerfile .

echo "docker build done and proceccing push repo..."

docker push $DUSER/$DREPO:$DTAG

#docker-close from app
# pkill -SIGHUP -f /Applications/Docker.app 'docker serve'
echo "${RED}docker i sclosed${NC}"

echo
echo "all job done....."
echo