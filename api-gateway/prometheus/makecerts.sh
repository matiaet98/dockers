#!/bin/bash

openssl \
    req -x509 \
    -nodes \
    -days 99999 \
    -newkey rsa:4096 \
    -keyout ./certs/prometheus.key \
    -out ./certs/prometheus.crt \
    -subj "/CN=poc-api-homo-2/O=AFIP/"
