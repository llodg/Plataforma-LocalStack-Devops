#!/bin/bash

echo "Checking platform health..."

echo "Checking Flask app..."
curl -f http://localhost/ || exit 1

echo ""
echo "Checking Prometheus..."
curl -f http://localhost:9090 || exit 1

echo ""
echo "Checking Grafana..."
curl -f http://localhost:3000 || exit 1

echo ""
echo "Checking LocalStack..."
curl -f http://localhost:4566 || exit 1

echo ""
echo "All services healthy."