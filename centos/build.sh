#!/bin/bash
docker build --rm -t centos7-systemd .
docker rmi centos:7
