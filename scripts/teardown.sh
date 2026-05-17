#!/bin/bash

echo "Stopping DevOps Platform..."

docker compose down -v

echo "Removing temporary files..."

rm -rf backups/temp/* 2>/dev/null || true

echo "Environment destroyed."