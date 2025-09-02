# Testing Your Spark on Kubernetes Lab

## Quick Status Check
```bash
make status
```
This shows:
- ✅ All 3 nodes are Ready
- ✅ Spark Operator pods are Running
- ✅ Current Spark applications

## Basic Cluster Tests

### 1. Test Cluster Connectivity
```bash
kubectl --kubeconfig=~/.kube/config-k3s cluster-info
```

### 2. Test Spark Installation
```bash
make test
```
This runs a basic Spark functionality test.

### 3. Test Individual Components

#### Check k3s cluster health:
```bash
kubectl --kubeconfig=~/.kube/config-k3s get nodes -o wide
kubectl --kubeconfig=~/.kube/config-k3s get pods --all-namespaces
```

#### Check Spark Operator:
```bash
kubectl --kubeconfig=~/.kube/config-k3s get pods -n spark-operator
kubectl --kubeconfig=~/.kube/config-k3s logs -n spark-operator deployment/spark-operator-controller
```

#### Check RBAC for Spark:
```bash
kubectl --kubeconfig=~/.kube/config-k3s get serviceaccount spark
kubectl --kubeconfig=~/.kube/config-k3s get clusterrole spark-role
kubectl --kubeconfig=~/.kube/config-k3s get clusterrolebinding spark-role-binding
```

## Advanced Testing

### Test with Simple Pod
```bash
kubectl --kubeconfig=~/.kube/config-k3s apply -f manifests/spark-test.yaml
kubectl --kubeconfig=~/.kube/config-k3s logs pod/spark-test
```

### Test Spark Operator (if working)
```bash
kubectl --kubeconfig=~/.kube/config-k3s apply -f manifests/spark-pi.yaml
kubectl --kubeconfig=~/.kube/config-k3s get sparkapplications
kubectl --kubeconfig=~/.kube/config-k3s describe sparkapplication spark-pi
```

## Manual Spark Test in VM

If you want to test Spark directly on the VMs:

### SSH into master node:
```bash
ssh -i ~/.ssh/id_ed25519 ubuntu@192.168.64.2
```

### Install Spark manually:
```bash
# On the VM:
curl -O https://archive.apache.org/dist/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz
tar -xzf spark-3.5.1-bin-hadoop3.tgz
cd spark-3.5.1-bin-hadoop3

# Test locally:
./bin/spark-submit \
  --class org.apache.spark.examples.SparkPi \
  --master local[2] \
  examples/jars/spark-examples_2.12-3.5.1.jar 10
```

## What's Working ✅

1. **Infrastructure**: 3-node k3s cluster with ARM64 Ubuntu VMs
2. **Networking**: All nodes can communicate
3. **Container Runtime**: containerd working properly
4. **Kubernetes**: API server, scheduler, controller-manager all healthy
5. **Spark Operator**: Deployed and running
6. **RBAC**: Service accounts and permissions configured
7. **Images**: ARM64 compatible Spark images pulling successfully

## Known Issues ⚠️

1. **Ivy Repository**: Spark shell has Ivy configuration issues in containerized environment
2. **Resource Limits**: May need tuning for smaller VMs
3. **Image Compatibility**: Some Spark images may not be fully ARM64 compatible

## Cleanup

```bash
# Clean test resources
make clean-tests

# Full cleanup
make destroy
```

## VS Code Tasks

You can run these tests from VS Code Command Palette:
- **Test Spark Cluster** - Runs basic functionality test
- **Check Cluster Status** - Shows cluster health
- **Clean Test Resources** - Removes test pods/jobs
