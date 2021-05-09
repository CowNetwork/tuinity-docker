#!/bin/bash
docker login ghcr.io -p $GHCR_TOKEN -u $GHCR_USER
docker build -t ghcr.io/cownetwork/tuinity:$1 .
docker push ghcr.io/cownetwork/tuinity:$1
