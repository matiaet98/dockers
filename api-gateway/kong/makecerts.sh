#!/bin/bash

openssl \
    req -x509 \
    -nodes \
    -days 99999 \
    -newkey rsa:4096 \
    -keyout ./certs/kong.key \
    -out ./certs/kong.crt \
    -subj "/CN=poc-api-homo-2/O=AFIP/"

openssl \
    req -x509 \
    -nodes \
    -days 99999 \
    -newkey rsa:4096 \
    -keyout ./certs/konga.key \
    -out ./certs/konga.crt \
    -subj "/CN=poc-api-homo-2/O=AFIP/"
