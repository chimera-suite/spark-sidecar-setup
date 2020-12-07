#! /bin/bash

echo "Checking enviroment variables..."

function check {
    [ -z "$2" ] && echo "Need to set $1" && exit 1;
}

TIMEOUT=120

check SPARK_MASTER $SPARK_MASTER

echo "Done!"

echo "Searching sql files in /init folder..."

number_of_files=$(ls /init/*.sql | wc -l)
echo "Found ${number_of_files} files."
for file in /init/*.sql
do
	echo "Found file ${file}"
done

echo "Waiting for Spark..."

set -e

./wait-for.sh "$SPARK_MASTER" --timeout=120

echo "Spark is ready!"

for file in /init/*.sql
do
	echo "Executing file ${file}"
  	/spark/bin/spark-sql \
		--name "chimera:spark-sidecar-setup - file ${file}" \
		--master "spark://$SPARK_MASTER" \
		--deploy-mode client  \
		-f "$file"
done