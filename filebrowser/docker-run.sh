#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "Must be run as root"
    exit 1
else
    if [ -z ${FILEBROWSER_PATH+x} ] ; then
        if [ -z "$1" ]; then
            echo "No path supplied"
            exit 1
        else
            FILEBROWSER_PATH=$1
        fi
    fi
fi

DOCKER_PATH="/docker-data/filebrowser/"
FILEBROWSER_DB_PATH="$DOCKER_PATH/filebrowser.db"
FILEBROWSER_SETTINGS_PATH="$DOCKER_PATH/config"

cd "$(dirname "$(readlink -f "$0")")" || exit 1
mkdir -p $DOCKER_PATH

if [ ! -f "$FILEBROWSER_SETTINGS_PATH" ] ; then
    mkdir $FILEBROWSER_SETTINGS_PATH
    echo -en '{\n    "port": 80,\n    "baseURL": "",\n    "address": "",\n    "log": "stdout",\n    "root": "/srv"\n}' > $FILEBROWSER_SETTINGS_PATH/settings.json
fi

if [ ! -f "$FILEBROWSER_DB_PATH" ] ; then
    touch $FILEBROWSER_DB_PATH
    chmod 1000:1000 $FILEBROWSER_DB_PATH
fi

#UserId:GroudId -> 1000:1000 must have folder permission
docker run \
    --name filebrowser --log-driver=journald --log-opt tag="{{.Name}}" --rm -d \
    -v $FILEBROWSER_DB_PATH:/filebrowser.db \
    -v $FILEBROWSER_SETTINGS_PATH:/config \
    -v "$FILEBROWSER_PATH":/srv \
    -u 1000:1000 \
    -p 80:80 \
    filebrowser/filebrowser
