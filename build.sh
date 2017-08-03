#!/usr/bin/env bash

IMAGE_NAME="danvittegleo/signal-desktop-osx:latest"

rm -rf SignalPrivateMessenger.app
docker build . -t ${IMAGE_NAME}
container_id=$(docker create ${IMAGE_NAME})
docker cp ${container_id}:/SignalPrivateMessenger.app SignalPrivateMessenger.app
docker rm ${container_id}
