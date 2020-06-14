#!/bin/bash

docker run \
	--detach \
	--name kong-envoy \
	--hostname kong-envoy \
	--network kong-network \
	--restart unless-stopped \
	-v $(pwd)/envoy.yaml:/etc/envoy/envoy.yaml \
	-p 1234:1234 \
	-p 4444:4444 \
envoyproxy/envoy-alpine:v1.14-latest

