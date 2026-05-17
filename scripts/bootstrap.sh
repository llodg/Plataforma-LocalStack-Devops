#!/bin/bash

set -e

echo "Starting full DevOps stack..."

docker compose down -v || true
docker compose up -d --build

echo "Waiting for LocalStack..."
sleep 8

echo "Creating S3 bucket..."

aws --endpoint-url=http://localhost:4566 s3 mb s3://devops-bucket 2>/dev/null || true

docker ps

echo "System ready"
echo "App: http://localhost"
echo "Grafana: http://localhost:3000"
echo "Prometheus: http://localhost:9090"