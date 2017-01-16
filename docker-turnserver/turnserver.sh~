#!/bin/bash

if [ -z $SKIP_AUTO_IP ] && [ -z $EXTERNAL_IP ]
then
    if [ ! -z $USE_IPV4 ]
    then
        EXTERNAL_IP=`curl -4 icanhazip.com 2> /dev/null`
    else
        EXTERNAL_IP=`curl icanhazip.com 2> /dev/null`
    fi
fi

if [ -z $PORT ]
then
    PORT=3478
fi

if [ ! -e /tmp/turnserver.configured ]
then
    if [ -z $SKIP_AUTO_IP ]
    then
        echo external-ip=$EXTERNAL_IP > /etc/turnserver.conf
    fi
    echo listening-port=$PORT >> /etc/turnserver.conf

    if [ ! -z $LISTEN_ON_PUBLIC_IP ]
    then
        echo listening-ip=$EXTERNAL_IP >> /etc/turnserver.conf
    fi

    touch /tmp/turnserver.configured
fi

exec /usr/bin/turnserver -v --syslog -a --max-bps=3000000 -f -m 3 --min-port=32355 --max-port=65535 --use-auth-secret --realm=realm --mysql-userdb="host=db dbname=coturn user=coturn password=1234 connect_timeout=30" --log-file=stdout --cipher-list=ALL $@
