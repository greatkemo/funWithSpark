SHELL := /bin/bash
PROJECT := spark-k8s-lab
KUBECONFIG := $(HOME)/.kube/config-k3s
MASTER := spark-master
WORKERS := spark-worker1 spark-worker2
SPARK_NS := spark-operator

.PHONY: vms ssh k3s kubeconfig helm submit logs demo destroy

vms:
	bash scripts/create_vms.sh

ssh:
	bash scripts/setup_ssh.sh

k3s:
	ansible-playbook -i inventory.ini ansible/k3s-cluster.yml

kubeconfig:
	bash scripts/fetch_kubeconfig.sh
	@echo "KUBECONFIG=$(KUBECONFIG)"; kubectl --kubeconfig=$(KUBECONFIG) get nodes

helm:
	helm repo add spark-operator https://kubeflow.github.io/spark-operator || true
	helm repo update
	KUBECONFIG=$(KUBECONFIG) helm upgrade --install spark-operator spark-operator/spark-operator \
	  --namespace $(SPARK_NS) --create-namespace \
	  --set sparkJobNamespace=default \
	  --set replicaCount=1 \
	  --set image.pullPolicy=IfNotPresent

submit:
	kubectl --kubeconfig=$(KUBECONFIG) apply -f manifests/spark-pi.yaml

logs:
	kubectl --kubeconfig=$(KUBECONFIG) logs -l spark-role=driver --tail=200 -f

test:
	kubectl --kubeconfig=$(KUBECONFIG) apply -f manifests/spark-cluster-test.yaml
	@echo "Waiting for test to complete..."
	kubectl --kubeconfig=$(KUBECONFIG) wait --for=condition=Complete job/spark-cluster-test --timeout=120s
	kubectl --kubeconfig=$(KUBECONFIG) logs job/spark-cluster-test

status:
	@echo "=== Cluster Status ==="
	kubectl --kubeconfig=$(KUBECONFIG) get nodes
	@echo ""
	@echo "=== Spark Operator Status ==="
	kubectl --kubeconfig=$(KUBECONFIG) get pods -n $(SPARK_NS)
	@echo ""
	@echo "=== Current Applications ==="
	kubectl --kubeconfig=$(KUBECONFIG) get sparkapplications 2>/dev/null || echo "No Spark applications found"

clean-tests:
	kubectl --kubeconfig=$(KUBECONFIG) delete job spark-cluster-test --ignore-not-found || true
	kubectl --kubeconfig=$(KUBECONFIG) delete pod spark-test --ignore-not-found || true
	kubectl --kubeconfig=$(KUBECONFIG) delete pod spark-pi-simple --ignore-not-found || true

demo: vms ssh k3s kubeconfig helm submit logs

destroy:
	kubectl --kubeconfig=$(KUBECONFIG) delete -f manifests/spark-pi.yaml --ignore-not-found || true
	KUBECONFIG=$(KUBECONFIG) helm uninstall spark-operator -n $(SPARK_NS) || true
	multipass delete spark-master spark-worker1 spark-worker2 || true
	multipass purge || true
