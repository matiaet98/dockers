#!/bin/bash

docker run \
-d \
-p 9200:9200 \
-p 9300:9300 \
-e "discovery.type=single-node" \
--name elastic \
docker.elastic.co/elasticsearch/elasticsearch:8.1.0

