#!/usr/bin/env bash

set -ex

kind create cluster \
  --config kind-config.yaml \
  --image=kindest/node:v1.27.1 \
  --name my-monitoring-stack \
  --retain \
  --wait=1m \
  -v 4
