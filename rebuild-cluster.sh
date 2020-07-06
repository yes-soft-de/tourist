#!/bin/bash

# Build new Images
# Config should be uploaded and ready

# This will build the server
docker build ./dev_symfony -f ./dev_symfony/server.Dockerfile -t gcr.io/tourists-280412/server-container:latest
docker build ./nginx -t gcr.io/tourists-280412/tourists-server:latest

# Stop running server
kubectl delete -f ./GKE/backend-deployment.yaml

# Start it again
kubectl create -f ./GKE/backend-deployment.yaml