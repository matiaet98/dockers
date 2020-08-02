#!/bin/bash

if [ "$(whoami)" != "hdfs" ]; then
        echo "Script must be run as user: hdfs"
        exit -1
fi

if [ ! -d /hadoop/namenode/current ]; then
  /hadoop/bin/hdfs namenode -format
fi

/hadoop/bin/hdfs namenode