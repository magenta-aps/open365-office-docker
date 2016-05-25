#!/bin/bash

# Builds docker image dependencies and this docker image.
# Assumes that open365-base-docker, and open365-base-with-dependencies-docker
# are cloned to the parent directory.

cd ../open365-base-docker
docker build -t open365-base .

cd ../open365-base-with-dependencies-docker
docker build -t open365-base-with-dependencies .

cd ../open365-office-docker
docker build -t open365-office .
