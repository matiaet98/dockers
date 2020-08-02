#!/bin/bash

if [ "$(whoami)" != "hdfs" ]; then
        echo "Script must be run as user: hdfs"
        exit -1
fi

/hadoop/bin/hdfs datanode
