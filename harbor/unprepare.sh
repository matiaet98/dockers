#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run with sudo" 
   exit 1
fi

if [[ $USER == "root" && $SUDO_USER == "root" ]]; then
   echo "This script must be run with sudo (not root!)" 
   exit 1
fi

chown -R $SUDO_USER:$SUDO_USER ./
