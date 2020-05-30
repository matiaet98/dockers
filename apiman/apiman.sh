#!/bin/bash

docker build -f manager/Dockerfile -t arquitectura/apiman-manager:latest .
docker build -f gateway/Dockerfile -t arquitectura/apiman-gateway:latest .

#remove intermediate images
docker rmi `docker images -f "dangling=true" -q`

# create network

docker network create apiman-network

# create volumes

docker volume create manager_elastic_vol
docker volume create gateway1_elastic_vol
docker volume create gateway2_elastic_vol

# create storage databases

docker run \
--detach \
--name manager_elastic \
--hostname manager_elastic \
--network apiman-network \
--env "discovery.type=single-node" \
--ulimit memlock=-1 \
-p 9201:9200 \
-p 9301:9300 \
-v manager_elastic_vol:/usr/share/elasticsearch/data \
elasticsearch:5.6-alpine

docker run \
--detach \
--name gateway1_elastic \
--hostname gateway1_elastic \
--network apiman-network \
--env "discovery.type=single-node" \
--ulimit memlock=-1 \
-p 9202:9200 \
-p 9302:9300 \
-v gateway1_elastic_vol:/usr/share/elasticsearch/data \
elasticsearch:5.6-alpine

docker run \
--detach \
--name gateway2_elastic \
--hostname gateway2_elastic \
--network apiman-network \
--env "discovery.type=single-node" \
--ulimit memlock=-1 \
-p 9203:9200 \
-p 9303:9300 \
-v gateway2_elastic_vol:/usr/share/elasticsearch/data \
elasticsearch:5.6-alpine

docker run \
--detach \
--name manager \
--hostname manager \
--network apiman-network \
-p 18080:8080 \
-p 18443:8443 \
-v $(pwd)/manager/conf/apiman.properties:/opt/jboss/wildfly/standalone/configuration/apiman.properties \
-v $(pwd)/manager/conf/standalone-apiman.xml:/opt/jboss/wildfly/standalone/configuration/standalone-apiman.xml \
arquitectura/apiman-manager

docker run \
--detach \
--name gateway1 \
--hostname gateway1 \
--network apiman-network \
-p 18081:8081 \
-p 18082:8082 \
-p 18444:8444 \
-v $(pwd)/gateway/conf/1/conf-es.json:/apiman-distro-vertx-1.5.5.Final/configs/conf-es.json \
arquitectura/apiman-gateway

docker run \
--detach \
--name gateway2 \
--hostname gateway2 \
--network apiman-network \
-p 28081:8081 \
-p 28082:8082 \
-p 28444:8444 \
-v $(pwd)/gateway/conf/2/conf-es.json:/apiman-distro-vertx-1.5.5.Final/configs/conf-es.json \
arquitectura/apiman-gateway

docker run \
--detach \
--name apiman_grafana \
--hostname apiman_grafana \
--network apiman-network \
-p 13000:3000 \
grafana/grafana:latest

