#!/bin/bash

docker build -f ./kong.dockerfile -t arquitectura/kong:latest .
docker build -f ./konga.dockerfile -t arquitectura/konga:latest .

#remove intermediate images
docker rmi `docker images -f "dangling=true" -q`

# create network
docker network create kong-network

# create volumes

docker volume create kong-postgres-vol
docker volume create konga-postgres-vol
docker volume create kong-prome-vol
docker volume create kong-elastic-vol

# create databases

docker run \
--detach \
--name kong-postgres \
--hostname kong-postgres \
--network kong-network \
-p 15432:5432 \
-e "POSTGRES_USER=kong" \
-e "POSTGRES_DB=kong" \
-e "POSTGRES_PASSWORD=kong" \
-v kong-postgres-vol:/var/lib/postgresql/data \
postgres:13-alpine

docker run \
--detach \
--name konga-postgres \
--hostname konga-postgres \
--network kong-network \
-p 25432:5432 \
-e "POSTGRES_USER=konga" \
-e "POSTGRES_DB=konga" \
-e "POSTGRES_PASSWORD=konga" \
-v konga-postgres-vol:/var/lib/postgresql/data \
postgres:11-alpine

# Initialize database for kong
docker run --rm \
    --network kong-network \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_PG_HOST=kong-postgres" \
    -e "KONG_PG_DATABASE=kong" \
    -e "KONG_PG_USER=kong" \
    -e "KONG_PG_PASSWORD=kong" \
arquitectura/kong:latest kong migrations bootstrap

# Initialize database for konga
docker run --rm \
--network kong-network \
arquitectura/konga:latest \
-c prepare -a postgres -u postgresql://konga:konga@konga-postgres:5432/konga

docker run \
--detach \
--name kong \
--hostname kong \
--network kong-network \
-p 18000:8000 \
-p 18443:8443 \
-p 127.0.0.1:18001:8001 \
-p 127.0.0.1:18444:8444 \
-e "KONG_DATABASE=postgres" \
-e "KONG_PG_HOST=kong-postgres" \
-e "KONG_PG_DATABASE=kong" \
-e "KONG_PG_USER=kong" \
-e "KONG_PG_PASSWORD=kong" \
-e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
-e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
-e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
-e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
-e "KONG_ADMIN_LISTEN=0.0.0.0:8001 reuseport backlog=16384, 0.0.0.0:8444 http2 ssl reuseport backlog=16384" \
-e "KONG_PROXY_LISTEN=0.0.0.0:8000 reuseport backlog=16384, 0.0.0.0:8443 http2 ssl reuseport backlog=16384" \
arquitectura/kong:latest

docker run \
--detach \
--name konga \
--hostname konga \
--network kong-network \
-p 1337:1337 \
-e "TOKEN_SECRET=0a4e42a5-2330-4e5e-8af0-b4dc28268fdb" \
-e "DB_ADAPTER=postgres" \
-e "DB_HOST=konga-postgres" \
-e "DB_USER=konga" \
-e "DB_PASSWORD=konga" \
-e "DB_DATABASE=konga" \
-e "NODE_ENV=production" \
arquitectura/konga:latest

docker run \
--detach \
--name kong-prome \
--hostname kong-prome \
--network kong-network \
-v kong-prome-vol:/prometheus \
-v $(pwd)/resources/prometheus.yml:/etc/prometheus/prometheus.yml \
-p 9090:9090 \
prom/prometheus:latest

docker run \
--detach \
--name kong-grafana \
--hostname kong-grafana \
--network kong-network \
-p 13000:3000 \
grafana/grafana:latest

docker run \
--detach \
--name kong-jaeger \
--hostname kong-jaeger \
--network kong-network \
-e COLLECTOR_ZIPKIN_HTTP_PORT=9411 \
-p 5778:5778 \
-p 16686:16686 \
-p 9411:9411 \
jaegertracing/all-in-one:1.18

docker run \
--detach \
--name kong-elastic \
--hostname kong-elastic \
--network kong-network \
--ulimit memlock=-1 \
-e "discovery.type=single-node" \
-e "opendistro_security.ssl.http.enabled=false" \
-v kong-elastic-vol:/usr/share/elasticsearch/data \
-p 9200:9200 \
-p 9600:9600 \
amazon/opendistro-for-elasticsearch:1.7.0


docker run \
--detach \
--name kong-kibana \
--hostname kong-kibana \
--network kong-network \
-e "ELASTICSEARCH_URL=http://kong-elastic:9200" \
-e "ELASTICSEARCH_HOSTS=http://kong-elastic:9200" \
-p 5601:5601 \
amazon/opendistro-for-elasticsearch-kibana:1.7.0

docker run \
--detach \
--name kong-logstash \
--hostname kong-logstash \
--network kong-network \
-v $(pwd)/resources/logstash.conf:/usr/share/logstash/pipeline/logstash.conf \
-e "LOG_LEVEL=debug" \
-p 5044:5044 \
docker.elastic.co/logstash/logstash-oss:7.7.0
