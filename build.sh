#!/bin/bash

# Build the docker image
docker build -t docker.io/schastel/anfy:latest .

# Push image to docker.io (need account)
# docker push docker.io/schastel/anfy:latest

#
#
#  U S A G E
#
#
# Pull image from docker.io (no account needed)
# docker pull docker.io/schastel/anfy:latest
#
# Run a container:
# docker run --rm -ti docker.io/schastel/anfy:latest bash
# Notes:
# --rm: Delete the container when exiting
# -ti: Interactive mode (equivalent to -t -i) 
#
# SUGGESTIONS:
# - Use a (local) docker volume to store the index files
# -> Save space 
# - Use a (local) docker volume for the work directory
# -> Save your work outside docker 
#
