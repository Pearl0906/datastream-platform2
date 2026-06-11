#!/bin/bash

set -e

apt-get update
apt-get install -y docker.io docker-compose

systemctl enable docker
systemctl start docker

# Create working directory
mkdir -p /opt/datastream
cd /opt/datastream

cat <<EOF > docker-compose.yml
version: "3.8"
services:
  engine:
    image: ubuntu:22.04
    command: sleep infinity
EOF

docker-compose up -d