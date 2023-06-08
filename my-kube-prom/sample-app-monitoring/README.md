### Setup monitoring for nginx-ingress-controller
1. install ingress controller through helm
```sh
# https://kubernetes.github.io/ingress-nginx/user-guide/monitoring/#configure-prometheus 
helm upgrade ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.metrics.enabled=true \
  --set-string controller.podAnnotations."prometheus\.io/scrape"="true" \
  --set-string controller.podAnnotations."prometheus\.io/port"="10254"
```

2. [download sample dashboards](https://github.com/kubernetes/ingress-nginx/tree/main/deploy/grafana/dashboards)

3. import the dashboards to [mycustom.jsonnet](../mycustom.jsonnet)
