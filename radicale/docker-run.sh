#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "Must be run as root"
    exit 1
fi

cd "$(dirname "$0")"

mkdir -p /docker-data/radicale/config
mkdir -p /docker-data/radicale/data

if [ ! -e "/docker-data/radicale/config/config" ]; then
    cp config /docker-data/radicale/config/
fi

docker run -d --rm --log-driver=journald --log-opt tag="{{.Name}}" \
    --name=radicale \
    -v /etc/timezone:/etc/timezone:ro -v /etc/localtime:/etc/localtime:ro \
    --net user_network --ip 10.0.0.83 \
    -v /docker-data/radicale/data:/data \
    -v /docker-data/radicale/config:/config:ro \
    tomsquest/docker-radicale && echo "radicale started."
