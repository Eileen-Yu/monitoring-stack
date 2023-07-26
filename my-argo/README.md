### Argo Workflow

#### Install Argo-workflow

```sh
k create ns argo

k apply -n argo \
  -f https://github.com/argoproj/argo-workflows/releases/download/v3.4.9/install.yaml

k wait deployment workflow-controller \
  --for condition=Available \
  --namespace argo
```

#### Patch argo-server auth

```sh
k patch deployment argo-server \
  --namespace argo \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [
  "server",
  "--auth-mode=server"
]}]'
```

#### Port-forward the UI

```sh
k port-forward -n argo deployment/argo-server 2746:2746
```

Visit: https://localhost:2746

#### Install Argo-workflow CLI

```sh
curl -sLO https://github.com/argoproj/argo-workflows/releases/download/v3.4.9/argo-darwin-amd64.gz

gunzip argo-darwin-amd64.gz

mv argo-darwin-amd64 argo

chmod +x argo

./argo version
```

#### Submit a workflow

```sh
./argo submit -n argo --watch https://raw.githubusercontent.com/argoproj/argo-workflows/master/examples/hello-world.yaml
```

Check workflow
```sh
./argo list -n argo
./argo get -n argo @latest
./argo logs -n argo @latest
```

#### Monitor Argo-workflow by Prometheus

Create a service for workflow-controller

```yaml
apiVersion: v1
kind: Service
metadata:
  name: workflow-controller-metrics
  namespace: argo
  labels:
    app: workflow-controller
spec:
  ports:
  - name: metrics
    port: 9090
    protocol: TCP
    targetPort: 9090
  selector:
    app: workflow-controller
  type: ClusterIP
```


Create a ServiceMonitor for the service

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: workflow-controller-metrics
  namespace: argo
spec:
  endpoints:
    - port: metrics
  namespaceSelector:
    matchNames:
      - argo
  selector:
    matchLabels:
      app: workflow-controller
```

Apply the above two manifests.
Then, go to the prometheus web ui.
Check the `Service Discovery`, then verify the `Targets`.
