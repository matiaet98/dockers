#!/bin/bash

if [ "$ROLE" == "MASTER" ]
then
    /spark/sbin/start-master.sh
elif [ "$ROLE" == "SLAVE" ]
then
    /spark/sbin/start-slave.sh
else
then
    /spark/sbin/start-master.sh
    /spark/sbin/start-slave.sh
fi

spark-shell \
--packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.0.0 \
<<EOF
:q
EOF
mv ~/.ivy2/jars/* /gdp/spark/jars/