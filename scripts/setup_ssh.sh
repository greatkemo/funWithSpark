#!/usr/bin/env bash
set -euo pipefail
KEY=${HOME}/.ssh/id_ed25519
[[ -f "$KEY" ]] || ssh-keygen -t ed25519 -f "$KEY" -N ""
for n in spark-master spark-worker1 spark-worker2; do
  multipass exec "$n" -- bash -lc 'mkdir -p ~/.ssh && chmod 700 ~/.ssh'
  multipass transfer "${KEY}.pub" "$n":/home/ubuntu/id_ed25519.pub
  multipass exec "$n" -- bash -lc 'cat ~/id_ed25519.pub >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys'
done

echo "SSH setup complete. Fill inventory.ini with VM IPs and run: make k3s"
