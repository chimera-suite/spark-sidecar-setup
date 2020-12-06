#! /bin/bash

echo "Checking enviroment variables..."

function check {
    [ -z "$2" ] && echo "Need to set $1" && exit 1;
}

TIMEOUT=120

check SPARK_MASTER $SPARK_MASTER

echo "Done!"

echo "Checking /init folder..."
echo "Found ${ls /etc | wc -l} files."
echo "Waiting for Spark..."

set -e

./wait-for.sh "$SPARK_MASTER" --timeout=120

echo "Spark is ready!"

for file in /init/*
do
  /spark/bin/spark-sql \
	--name SPARKSQL-INSERTIONS \
	--master "spark://$SPARK_MASTER" \
	--deploy-mode client  \
	-f "$file"
done