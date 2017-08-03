#!/usr/bin/env bash

IMAGE_NAME="danvittegleo/signal-desktop-osx:latest"

rm -rf build/*
docker build . -t ${IMAGE_NAME}
container_id=$(docker create ${IMAGE_NAME})
docker cp ${container_id}:/SignalPrivateMessenger.app build/SignalPrivateMessenger.app
docker rm ${container_id}
cd build && zip -r SignalPrivateMessenger.zip SignalPrivateMessenger.app
