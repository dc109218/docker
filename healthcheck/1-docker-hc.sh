#!/bin/bash

INTERVAL=60

while :
do
    GRAPHQL="$(wget --quiet --tries=1 --spider http://localhost:3000/graphql/healthcheck; echo $?)"
    if [[ $GRAPHQL == 0 ]];then
        echo -e "Graphql is running ! \nNoAction"
    else
        echo -e "Error for Graphql ! \nRestart"
    fi
    REST="$(wget --quiet --tries=1 --spider http://localhost:4000/rest/healthcheck; echo $?)"
    if [[ $REST == 0 ]];then
        echo -e "Rest is running ! \nNoAction"
    else
        echo -e "Error for Rest ! \nRestart"
    fi
    SOCKET="$(wget --quiet --tries=1 --spider http://localhost:6000/healthcheck; echo $?)"
    if [[ $SOCKET == 0 ]];then
        echo -e "Socket is running ! \nNoAction"
    else
        echo -e "Error for Socket ! \nRestart"
    fi
    
    echo =====${INTERVAL}s=====
    echo 
    sleep $INTERVAL
done