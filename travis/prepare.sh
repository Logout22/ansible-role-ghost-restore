#!/bin/sh
docker pull "$1"
docker build --file=travis/Dockerfile."$1" --tag="$1":ansible travis

