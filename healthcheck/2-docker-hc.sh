#!/usr/bin/env sh

INTERVAL=300

curlCall() {
    docker restart $1 > /dev/null 2>&1
    echo
    WEBURL="https://sareteam227.webhook.office.com/webhookb2/51c0fa03-3e01-420b-9c54-5a45a7076513@2d90f6ac-4135-4fb5-b54b-745e14d0c51f/IncomingWebhook/808a1c3a02b148128ee173b4295b5550/8dbe73bd-2c14-4449-9b80-846cdbcc96d4"
    curl --location --request POST $WEBURL --header 'Content-Type: application/json' \
    --data-raw '{
        "@type": "MessageCard",
        "@context": "http://schema.org/extensions",
        "themeColor": "FF0000",
        "summary": "Syno Server Docker Status",
        "sections": [{
            "activityTitle": "mySyno Server Docker Status",
            "activitySubtitle": "Error dome docker container",
            "activityImage": "https://sflanders.net/wp-content/uploads/2015/11/synology-150x150.png",
            "facts": [{
                "name": "'$1'",
                "value": "'$2'"
            }],
            "markdown": true
        }]
    }'
}
while :
do
    GRAPHQL="$(wget --quiet --tries=1 --spider http://localhost:3000/graphql/healthcheck; echo $?)"
    if [[ $GRAPHQL == 0 ]];then
        echo -e "Graphql is running!"
    else
        echo -e "Error for Graphql! & Restart"
        GRACALL=`echo Error_for_Graphql_$GRAPHQL`
        curlCall graphql $GRACALL
    fi
    REST="$(wget --quiet --tries=1 --spider http://localhost:4000/rest/healthcheck; echo $?)"
    if [[ $REST == 0 ]];then
        echo -e "Rest is running!"
    else
        echo -e "Error for Rest! & Restart"
        RESTCALL=`echo Error_for_Rest_$REST`
        curlCall rest $RESTCALL
    fi
    SOCKET="$(wget --quiet --tries=1 --spider http://localhost:6000/healthcheck; echo $?)"
    if [[ $SOCKET == 0 ]];then
        echo -e "Socket is running!"
    else
        echo -e "Error for Socket! & Restart"
        SOCKCALL=`echo Error_for_Socket_$SOCKET`
        curlCall socket $SOCKCALL
    fi
    echo =====${INTERVAL}s=====
    echo 
    sleep $INTERVAL
done