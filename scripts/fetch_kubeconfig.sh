#!/usr/bin/env bash
set -euo pipefail
MASTER_IP=$(grep spark-master inventory.ini | awk '{for(i=1;i<=NF;i++){if($i~"ansible_host="){split($i,a,"="); print a[2]}}}')
[[ -n "$MASTER_IP" ]] || { echo "Set ansible_host for spark-master in inventory.ini"; exit 1; }
mkdir -p ~/.kube
scp -i ${HOME}/.ssh/id_ed25519 -o StrictHostKeyChecking=no ubuntu@${MASTER_IP}:/etc/rancher/k3s/k3s.yaml ~/.kube/config-k3s
# Point the kubeconfig to master IP (k3s writes '127.0.0.1')
sed -i '' "s/127.0.0.1/${MASTER_IP}/g" ~/.kube/config-k3s
export KUBECONFIG=${HOME}/.kube/config-k3s
kubectl --kubeconfig=${HOME}/.kube/config-k3s get nodes
