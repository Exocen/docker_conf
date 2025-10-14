#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "Must be run as root"
    exit 1
fi

#PGUID 1000 PGID 1000 -> must have folder permission
docker run -d --rm --log-driver=journald --log-opt tag="{{.Name}}" \
    --name=jellyseerr\
    -v /etc/timezone:/etc/timezone:ro -v /etc/localtime:/etc/localtime:ro \
    --network=container:gluetun \
    -v "$TRANSMISSION_DL_PATH":/data/movies \
    -v /docker-data/jellyseerr:/app/config \
    fallenbagel/jellyseerr:latest && echo "Jellyseerr started."
