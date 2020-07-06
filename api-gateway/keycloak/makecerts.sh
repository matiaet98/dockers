#!/bin/bash

openssl \
    req -x509 \
    -nodes \
    -days 99999 \
    -newkey rsa:4096 \
    -keyout ./certs/keycloak.key \
    -out ./certs/keycloak.crt \
    -subj "/CN=poc-api-homo-1/O=AFIP/"
