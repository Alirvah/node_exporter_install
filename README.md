# node_exporter_install

Installation script for node_exporter

Usage:
```
./install_node_exporter.sh 1.7.0 linux-arm64
sudo ufw allow from <IP where prometheus runs> to any port 9100 comment 'Allow Prometheus server to scrape Node Exporter metrics'
```
