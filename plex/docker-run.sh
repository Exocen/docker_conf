#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "Must be run as root"
    exit 1
else
    if [ -z ${PLEX_PATH+x} ] ; then
        if [ -z "$1" ]; then
            echo "No path supplied"
            exit 1
        else
            PLEX_PATH=$1
        fi
    fi
fi

docker run -d --rm --log-driver=journald --log-opt tag="{{.Name}}" \
    -e "TZ=$(timedatectl status | grep "zone" | sed -e 's/^[ ]*Time zone: \(.*\) (.*)$/\1/g')" \
    --network=host \
    -e PUID=1000 \
    -e PGID=1000 \
    -v /docker-data-nobackup/plex:/config \
    -v "$PLEX_PATH":/media_files \
    --name=plex \
    linuxserver/plex:latest && echo "Plex started."
