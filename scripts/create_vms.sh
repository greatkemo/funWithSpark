#!/usr/bin/env bash
set -euo pipefail
# Adjust resources as desired
multipass launch 24.04 --name spark-master  --cpus 4 --memory 8G  --disk 30G || true
multipass launch 24.04 --name spark-worker1 --cpus 4 --memory 8G  --disk 30G || true
multipass launch 24.04 --name spark-worker2 --cpus 4 --memory 8G  --disk 30G || true

multipass list

echo ""
echo "Update inventory.ini with these IPs (ansible_host)."
