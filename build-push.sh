#! /bin/bash

SPARK_VERSIONS=(
    "1.5.1-hadoop2.6"
    "1.6.2-hadoop2.6"
    "1.6.3-nohadoop-java8"
    "1.6.3-nohadoop-java8-scala2.11"
    "2.0.0-hadoop2.7-hive"
    "2.0.0-hadoop2.7-hive-java8"
    "2.0.1-hadoop2.7"
    "2.0.2-hadoop2.7"
    "2.1.0-bigtop-java8"
    "2.1.0-hadoop2.7"
    "2.1.0-hadoop2.8-hive-java8"
    "2.1.1-hadoop2.7"
    "2.1.2-hadoop2.7"
    "2.1.3-hadoop2.7"
    "2.2.0-hadoop2.7"
    "2.2.0-hadoop2.8-hive-java8"
    "2.2.1-hadoop2.7"
    "2.2.2-hadoop2.7"
    "2.3.0-hadoop2.7"
    "2.3.1-hadoop2.7"
    "2.3.1-hadoop2.8"
    "2.3.2-hadoop2.7"
    "2.3.2-hadoop2.8"
    "2.3.2-hadoop3.1.1-java8"
    "2.4.0-hadoop2.7"
    "2.4.0-hadoop2.8"
    "2.4.0-hadoop2.8-scala2.12"
    "2.4.0-hadoop3.1"
    "2.4.1-hadoop2.7"
    "2.4.3-hadoop2.7"
    "2.4.4-hadoop2.7"
    "2.4.5-hadoop2.7"
    "3.0.0-hadoop3.2"
    "3.0.1-hadoop3.2"
)

echo "Enter you dockerhub credentials"
read -p "Username:" username
read -s -p "Password:" password
echo ""

echo "${password}" | docker login --username "${username}" --password-stdin

for SPARK_VERSION in ${SPARK_VERSIONS[@]}; do
    echo "Build with tag ${SPARK_VERSION}"
    docker build --build-arg "SPARK_VERSION=${SPARK_VERSION}" \
        -t "chimerasuite/spark-sidecar-setup:${SPARK_VERSION}" . 
    docker push "chimerasuite/spark-sidecar-setup:${SPARK_VERSION}"
done