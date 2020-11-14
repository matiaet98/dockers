#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run with sudo" 
   exit 1
fi

if [[ $USER == "root" && $SUDO_USER == "root" ]]; then
   echo "This script must be run with sudo (not root!)" 
   exit 1
fi

mkdir -p /data/harbor/registry
mkdir -p /data/harbor/secret/registry
mkdir -p /data/harbor/database
mkdir -p /data/harbor/ca_download
mkdir -p /data/harbor/secret/core
mkdir -p /data/harbor/secret/keys
mkdir -p /data/harbor/secret/cert
mkdir -p /data/harbor/job_logs
mkdir -p /data/harbor/redis
mkdir -p /data/harbor/chart_storage
mkdir -p /data/trivy-adapter/trivy
mkdir -p /data/trivy-adapter/reports


chown -R 10000:$SUDO_USER ./config
chown -R 10000:$SUDO_USER /data/harbor/ca_download
chown -R 10000:$SUDO_USER /data/harbor/chart_storage
chown -R 10000:$SUDO_USER /data/harbor/job_logs
chown -R 10000:$SUDO_USER /data/harbor/registry
chown -R 999:$SUDO_USER /data/harbor/redis
chown -R 999:$SUDO_USER /data/harbor/database