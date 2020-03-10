
## Installing prereqs
As helmchart are not currently supporting checking if a namespace exist before applying there is a prereqs file that must be applied in the cluster.
```bash
kubectl apply -f prereq-stack.yaml
```

### Install argo CRDs
> This step is only done once before the initial deployment of helm charts. If you redeploy helm charts this doesnt need to be re-run.

```bash
kubectl apply -f https://raw.githubusercontent.com/argoproj/argo/master/manifests/base/crds/workflow-crd.yaml
kubectl apply -f https://github.com/argoproj/argo-events/raw/v0.11/hack/k8s/manifests/sensor-crd.yaml
kubectl apply -f https://github.com/argoproj/argo-events/raw/v0.11/hack/k8s/manifests/gateway-crd.yaml
```

## Edit values
Starting from Helm v.3.0.3 there is now a way to get the default values out of the helm chart direcly.
Running
```bash
helm show values scaleout/stack >> local-values.yaml
```
will give you a local-values.yaml to edit that is a copy of the default values.


## Installing the stack helmchart

1. Installing with default values

```bash
helm install your-release-name stack
```

2. Installing with your custom values

```bash
helm install your-release-name stack --values=local-values.yaml
```
