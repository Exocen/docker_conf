#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "Must be run as root"
    exit 1
else
    if [ -z ${RADICALE_PATH+x} ] ; then
        if [ -z "$1" ]; then
            RADICALE_PATH="/docker-data/radicale/"
        fi
    fi
fi

docker run -d --rm --log-driver=journald --log-opt tag="{{.Name}}" \
    --name=radicale \
    -v /etc/timezone:/etc/timezone:ro -v /etc/localtime:/etc/localtime:ro \
    --net user_network --ip 10.0.0.83 \
    -v "$RADICALE_PATH":/data \
    tomsquest/docker-radicale && echo "radicale started."
