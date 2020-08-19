#!/bin/bash

openssl \
    req -x509 \
    -nodes \
    -days 99999 \
    -newkey rsa:4096 \
    -keyout ./certs/matinet.key \
    -out ./certs/matinet.crt \
    -subj "/CN=*.matinet/"

