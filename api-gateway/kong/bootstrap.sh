#!/bin/bash

docker-compose up -d kong-postgres
docker-compose up -d konga-postgres

sleep 10 # Hay que esperar que la base arranque antes de hacerle el bootstrap

source .env

docker run --rm \
    --network kong-net \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_PG_HOST=kong-postgres" \
    -e "KONG_PG_PORT=5432" \
    -e "KONG_PG_DATABASE=${KONG_POSTGRES_DB}" \
    -e "KONG_PG_USER=${KONG_POSTGRES_USER}" \
    -e "KONG_PG_PASSWORD=${KONG_POSTGRES_PASSWORD}" \
arquitectura/kong:latest kong migrations bootstrap

docker run --rm \
--network kong-net \
pantsel/konga:latest \
-c prepare -a postgres -u postgresql://${KONGA_POSTGRES_USER}:${KONGA_POSTGRES_PASSWORD}@konga-postgres:5432/${KONGA_POSTGRES_DB}

docker-compose up -d