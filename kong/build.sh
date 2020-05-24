#!/bin/bash

docker run --rm \
     --network=matinet \
     -e "KONG_DATABASE=postgres" \
     -e "KONG_PG_HOST=postgres" \
     -e "KONG_PG_PASSWORD=kong" \
     kong:latest kong migrations bootstrap

