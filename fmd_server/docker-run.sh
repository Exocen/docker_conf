#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "Must be run as root"
    exit 1
fi

docker run -d --rm --log-driver=journald --log-opt tag="{{.Name}}" \
    -v /etc/timezone:/etc/timezone:ro -v /etc/localtime:/etc/localtime:ro \
    -v /docker-data/fmd-server/:/var/lib/fmd-server/db/ \
    --net user_network --ip 10.0.0.83 \
    --name=fmd_server \
    registry.gitlab.com/fmd-foss/fmd-server && echo "fmd_server started."
