#!/bin/bash

echo "start\n"
set -e

CYN=$'\e[0;36m'
YLW=$'\e[0;33m'
BLE=$'\e[0;35m'
GRN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

DFILE='1.Dockerfile'
DOCKER_USR='dcsurani'
DOCKER_REPO='iwillbackend'
GBRANCH="$(git rev-parse --abbrev-ref HEAD)" # GBRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
TAG_DATE=$(date +'%d%m%y.%H%M%S')

# Create Dockerfile
# cat << EOF > Dockerfile
# # dockerfile create

# EOF

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
  #  rm $DFILE
   echo "$DFILE is removed"
fi

docker push $DOCKER_USR/$DOCKER_REPO:$TAG_DATE
echo "${BLE}Docker Hub ${YLW}Image ${NC}push done..."

#docker-close from app
# pkill -SIGHUP -f /Applications/Docker.app 'docker serve'
# echo "${RED}docker i sclosed${NC}"

echo "#$DOCKER_USR/$DOCKER_REPO:$TAG_DATE" >> 1.run.sh

echo "${GRN}============================"
echo "${CYN}All ${YLW}Job ${GRN}Completed ${BLE}.........."
echo "${GRN}============================"

#dcsurani/iwillbackend:030922.234436
