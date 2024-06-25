#!/bin/bash
output=`mongo --quiet --eval 'db.isMaster().ismaster'`

if [[ "$output" == 'true' ]]
then
  http_type="HTTP/1.0 200 OK"
  mongo="master"
else
  http_type="HTTP/1.0 503 Service Unavailable"
  mongo="slave"
fi

echo $http_type
sleep 0.1
echo "Content-Type: text/html; charset=utf-8"
sleep 0.1
echo "Connection: close"
sleep 0.1
response="MongoDB is $mongo"
sleep 0.1
length=$(echo $response | wc -c)
sleep 0.1
echo "Content-Length: $length"
sleep 0.1
echo ""
sleep 0.1
echo $response
exit 0