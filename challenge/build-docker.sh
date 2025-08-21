#!/bin/bash
NAME="mrmantza"
CAT="osint"
docker rm -f ${CAT}_${NAME}
docker build --tag=${CAT}_${NAME} .
docker run -p 1337:1337 --rm --name=${CAT}_${NAME} --detach ${CAT}_${NAME}
