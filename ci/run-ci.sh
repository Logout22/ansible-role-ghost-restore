#!/bin/bash

set -o errexit
set -o nounset

cleanup() {
    rm -f testmachine{,.pub} .env
}

trap cleanup EXIT
ssh-keygen -b 2048 -t rsa -f testmachine -q -N ""
echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" > .env
echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" > .env
docker-compose build --pull
docker-compose up --abort-on-container-exit