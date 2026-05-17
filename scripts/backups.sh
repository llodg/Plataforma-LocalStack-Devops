#!/bin/bash

DATE=$(date +%F-%H-%M)

BACKUP_DIR="backups/$DATE"

mkdir -p $BACKUP_DIR

echo "Creating backup at $BACKUP_DIR"

cp docker-compose.yml $BACKUP_DIR/

cp -r monitoring $BACKUP_DIR/ 2>/dev/null || true
cp -r nginx $BACKUP_DIR/ 2>/dev/null || true
cp -r app $BACKUP_DIR/ 2>/dev/null || true
cp .env $BACKUP_DIR/ 2>/dev/null || true

echo "Backup completed."