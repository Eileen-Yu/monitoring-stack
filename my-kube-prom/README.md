### kube-prometheus Quick Start

```sh
# 1. generate kubernetes resources manifests
./build.sh mycustom.jsonnet

# 2. apply manifests
k apply --server-side -f manifests/setup
k apply -f manifests
```

#### Questions
1. Can we drop the flag `--server-side`?
