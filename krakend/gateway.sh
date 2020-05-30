#!/bin/bash

docker run \
	--name krakend \
	--hostname krakend \
	--network matinet \
	-d \
	--ulimit memlock=-1 \
	-p 50000:8080 \
	--mount type=bind,src=$(pwd)/conf/,dst=/etc/krakend/ \
devopsfaith/krakend:latest

