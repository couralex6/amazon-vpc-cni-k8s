#!/bin/bash


# to run: 
# KUBE_CONFIG_PATH=/Users/courouba/.kube/config ./run-ginkgo.sh

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "Running VPC CNI integration test with the following variable:
KUBE CONFIG: $KUBE_CONFIG_PATH
"

echo "CNI version running on cluster:"
kubectl describe daemonset aws-node -n kube-system --kubeconfig $KUBE_CONFIG_PATH | grep Image | cut -d "/" -f 2

cd $SCRIPT_DIR
cd ../test/integration

echo "Starting the ginkgo test suite" 
GO111MODULE=on go test -v -timeout 0 ./... --kubeconfig=$KUBE_CONFIG_PATH --ginkgo.focus="\[cni-integration\]" --ginkgo.skip="\[Disruptive\]" --assets=./assets