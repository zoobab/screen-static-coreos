#!/bin/bash
WORKDIR="$PWD/bin"
mkdir -pv $WORKDIR
VER=$(grep "ENV VER" Dockerfile | grep -v '^[[:space:]]*#' | cut -d" " -f3)
docker build -t screen-static-coreos:latest .
docker run -v $WORKDIR:/mnt screen-static-coreos:latest cp -v /home/core/screen-$VER/screen /mnt
docker run -v $WORKDIR:/mnt screen-static-coreos:latest cp -v /home/core/screen-$VER/screen-upx /mnt
mv $WORKDIR/screen $WORKDIR/screen-non-upx
mv $WORKDIR/screen-upx $WORKDIR/screen
