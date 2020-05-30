#!/bin/bash

docker run \
	--name kdesigner \
	--hostname kdesigner \
	-d \
	-p 28080:80 \
devopsfaith/krakendesigner

