#!/bin/bash

docker run \
    -d \
    --name sentry-redis \
    --restart on-failure \
    redis:6-alpine

docker run \
    -d \
    --name sentry-postgres \
    --restart on-failure \
    -e "POSTGRES_PASSWORD=sentry" \
    -e "POSTGRES_USER=sentry" \
    -e "POSTGRES_DB=sentry" \
    postgres:13-alpine


KEY=$(uuidgen)

docker run -it --rm -e SENTRY_SECRET_KEY=$KEY --link sentry-postgres:postgres --link sentry-redis:redis sentry:9 upgrade

docker run \
    -d \
    --name sentry \
    -e SENTRY_SECRET_KEY=$KEY \
    --restart on-failure \
    -p 9000:9000 \
    --link sentry-redis:redis \
    --link sentry-postgres:postgres \
sentry:9

docker run \
    -d \
    --name sentry-cron \
    -e SENTRY_SECRET_KEY=$KEY \
    --restart on-failure \
    --link sentry-postgres:postgres \
    --link sentry-redis:redis \
sentry:9 run cron

docker run \
-d \
--name sentry-worker-1 \
--restart on-failure \
-e SENTRY_SECRET_KEY=$KEY \
--link sentry-postgres:postgres \
--link sentry-redis:redis \
sentry:9 run worker