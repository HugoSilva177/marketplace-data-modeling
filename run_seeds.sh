#!/bin/bash

IMAGE_NAME=marketplace-dbt
docker rmi $(docker images -f dangling=true -q) 2> /dev/null

docker build -t $IMAGE_NAME -f Dockerfile .
external_command="$*"
docker run -v "$(pwd)/duckdb:/app/duckdb" $IMAGE_NAME sh -c  "python3 /app/main.py 'dbt seed --full-refresh'"