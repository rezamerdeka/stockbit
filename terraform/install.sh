#! /bin/bash

sudo apt-get -y update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo apt-get install -y docker.io=20.10.7-0ubuntu5~18.04.3
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose
cat > /home/ubuntu/init.sql << EOF
CREATE TABLE IF NOT EXISTS items(
id SERIAL PRIMARY KEY,
name VARCHAR(100) NOT NULL,
description TEXT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
EOF
cat > /home/ubuntu/.env << EOF
POSTGRES_USER=bucketeer
POSTGRES_PASSWORD=bucketeer_pass
POSTGRES_DB=bucketeer_db
EOF
cat > /home/ubuntu/docker-compose.yml << EOF
version: "3.7"
services:
  database:
    image: postgres
    restart: always
    env_file:
      - .env
    ports:
      - "5432:5432"
    volumes:
      - data:/var/lib/postgresql/data
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 5s
      timeout: 5s
      retries: 5
  server:
#    build:
#      context: .
#      dockerfile: Dockerfile
    image: rezamerdeka/stockbit:latest
    env_file: .env
    depends_on:
      database:
         condition: service_healthy
    links:
      - database
    networks:
      - default
    ports:
    - "8080:8080"
volumes:
  data:
EOF
cd /home/ubuntu/ && sudo docker-compose up -d
