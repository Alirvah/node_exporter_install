#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <node_exporter_version> <architecture>"
    echo "Example: $0 1.3.1 linux-amd64"
    exit 1
fi

NODE_EXPORTER_VERSION="$1"
ARCH="$2"

wget "https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.${ARCH}.tar.gz"

if [ "$?" -ne 0 ]; then
    echo "Failed to download Node Exporter. Please check the version and architecture."
    exit 1
fi

tar xvfz "node_exporter-${NODE_EXPORTER_VERSION}.${ARCH}.tar.gz"
sudo mv "node_exporter-${NODE_EXPORTER_VERSION}.${ARCH}/node_exporter" /usr/local/bin/

rm -rf "node_exporter-${NODE_EXPORTER_VERSION}.${ARCH}.tar.gz" "node_exporter-${NODE_EXPORTER_VERSION}.${ARCH}"

echo "[Unit]
Description=Node Exporter

[Service]
User=nobody
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/node_exporter.service

sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

echo "Node Exporter v${NODE_EXPORTER_VERSION} for ${ARCH} installed and started successfully."
