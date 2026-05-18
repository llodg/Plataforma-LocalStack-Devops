#!/bin/bash

set -e

echo " DevOps Platform Bootstrap Starting "

check_command() {
    if ! command -v $1 &> /dev/null
    then
        echo "[ERROR] $1 is not installed."
        exit 1
    fi
}

echo "Checking dependencies..."

check_command docker
check_command aws

echo "Dependencies found."

echo "Starting Docker stack..."

docker compose down -v || true
docker compose up -d --build

echo "Waiting for LocalStack..."

until curl -s http://localhost:4566 > /dev/null
do
    sleep 2
done

echo "LocalStack ready."

echo "Creating S3 bucket..."

aws --endpoint-url=http://localhost:4566 s3 mb s3://devops-bucket 2>/dev/null || true

echo "Bucket ready."

echo "Checking application..."

until curl -s http://localhost/ > /dev/null
do
    sleep 2
done

echo "App responding."

echo " Stack Ready "

echo "Application:  http://localhost"
echo "Prometheus:   http://localhost:9090"
echo "Grafana:      http://localhost:3000"
echo "Alertmanager: http://localhost:9093"