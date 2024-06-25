docker network create --driver=bridge --driver=bridge --subnet=192.168.1.0/16 role

mongodb = 192.168.224.2

docker inspect --format "{{json .State.Health }}" router-01 | jq`

====

curl -fsS http://127.0.0.1:19111/healthcheck
wget --quiet --tries=1 --spider http://127.0.0.1/healthcheck; echo $?

docker inspect --format "{{json .State.Health }}" ffmpeg | jq


curl -fsS http://127.0.0.1:8080/healthcheck


curl -fsS http://13.233.212.141/healthcheck

ab -n 10000 -c 10 http://192.168.33.200/