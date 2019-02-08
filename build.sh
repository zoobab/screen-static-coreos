#!/bin/bash
WORKDIR="$PWD/bin"
mkdir -pv $WORKDIR
docker build -t screen-static-coreos:latest .
docker run -v $WORKDIR:/mnt screen-static-coreos:latest cp -v /home/core/screen-4.6.2/screen /mnt
