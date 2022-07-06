STACKn
======

## Description

A Helm chart for deploying STACKn by Scaleout

Current chart version is 0.2.0

## Chart Requirements

| Repository | Name | Version | Optional |
|------------|------|---------|----------|
| https://charts.bitnami.com/bitnami | postgresql | 11.6.14 | No
| https://charts.bitnami.com/bitnami | postgresql-ha | 9.2.0 | Yes
| https://grafana.github.io/helm-charts | grafana | 6.8.4 | Yes
| https://grafana.github.io/helm-charts | loki-stack | 2.3.1 | Yes
| https://prometheus-community.github.io/helm-charts | prometheus | 13.8.0 | Yes
| https://stakater.github.io/stakater-charts | reloader | v0.0.86 | No

## Configuration

By default STACKn has been configured with a dns wildcard domain for localhost. To change this replace all occurences of studio.127.0.0.1.nip.io in values.yaml.

STACKn requires access to manipulate and create recourses in the k8s cluster. Thus, it needs the cluster config as a secret in ./templates/chart-controller-secret.yaml.

By default no StorageClassName is set and needs to provided in the values.yaml or by using `--set` argument.

### Quick deployment

```bash
# Generate k8s cluster config file - NOTE: we assume a k8s cluster is already installed and configured
cluster_config=$(cat ~/.kube/config  | base64 | tr -d '\n')

# Deploy STACKn from this repository
helm install --set kubeconfig=$cluster_config --set global.postgresql.storageClass=<your-storage-class> stackn .
```

All resources will by default be created in the Namescape "default".
STACKn studio will be avaliable at http://studio.127.0.0.1.nip.io

## Deploy an SSL certificate

For production you need a domain name with a wildcard SSL certificate. If your domain is your-domain.com, you will need a certificate for *.your-domain.com and *.studio.your-domain.com. Assuming that your certificate is fullchain.pem and your private key privkey.pem, you can create a secret `prod-ingress` containing the certificate with the command:
```
kubectl create secret tls prod-ingress --cert fullchain.pem --key privkey.pem
```

## Global values
Minimal requirement: `global.postgresql.storageClass`

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.studio.existingSecret | string | `""` | Use existing secret. See basic-secrets.yaml. |
| global.studio.storageClass | string | `""` | StorageClassName for PVC. Overrides `studio.storage.storageClass`. If `studio.storage.storageClass` is unset (default) will inherent from `global.postgresql.storageClass`  |
| global.studio.superUser | string | `admin` | Django superUser. Obs will always be `admin` until fixed. |
| global.studio.superuserEmail | string | `'admin@test.com'` | Django superUser email. Obs will always be `admin@test.com` until fixed. |
| global.studio.superuserPassword | string | `""` | Django superUser password. If left empty, will generate. |
| global.postgresql.auth.username | string | `stackn` | Postgres user will be created |
| global.postgresql.auth.password | string | `""` | Postgres password for user above. If empty, will be generated and stored in secret `stackn-studio-postgres` |
| global.postgresql.auth.database | string | `stackn` | Postgres database will be created |
| global.postgresql.auth.postgresPassword | string | `""` | Postgres password for postgres user If empty, will be generated and stored in secret `stackn-studio-postgres` |
| global.postgresql.auth.existingSecret | string | `""` | will not create secret `stackn-studio-postgres`. Instead use existing secret for postgres|
| global.postgresql.storageClass | string | `""` | StorageClassName for PVC |



## Values

Minimal requirement: `kubeconfig`

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| celeryWorkers.replicas | int | `2` |  |
| celeryWorkers.resources.limits.cpu | string | `"1000m"` |  |
| celeryWorkers.resources.limits.memory | string | `"8Gi"` |  |
| celeryWorkers.resources.requests.cpu | string | `"100m"` |  |
| celeryWorkers.resources.requests.memory | string | `"1Gi"` |  |
| chartcontroller.branch | string | `"develop"` |  |
| chartcontroller.enabled | bool | `false` |  |
| chartcontroller.image.pullPolicy | string | `"Always"` |  |
| chartcontroller.image.repository | string | `"registry.<your-domain.com>/chart-controller:develop"` |  |
| kubeconfig | string | `""` | Encoded (base64) kubernetes config  |
| docker-registry.enabled | bool | `false` |  |
| docker-registry.ingress.enabled | bool | `true` |  |
| docker-registry.ingress.hosts[0] | string | `"registry.<your-domain.com>"` |  |
| docker-registry.ingress.tls[0].hosts[0] | string | `"registry.<your-domain.com>"` |  |
| docker-registry.ingress.tls[0].secretName | string | `"prod-ingress"` |  |
| docker-registry.persistence.accessMode | string | `"ReadWriteOnce"` |  |
| docker-registry.persistence.enabled | bool | `true` |  |
| docker-registry.persistence.size | string | `"2Gi"` |  |
| docker-registry.persistence.storageClass | string | `"microk8s-hostpath"` |  |
| domain | string | `studio.<your-domain.com>` |  |
| auth_domain | string | `"stackn-studio.default.svc.cluster.local"` |  |
| session_cookie_domain | string | `.<your-domain.com>` |  |
| existingSecret | string | `""` |  |
| fixtures | string | `""` |  |
| grafana."grafana.ini".server.domain | string | `"grafana.<your-domain.com>"` |  |
| grafana."grafana.ini".server.root_url | string | `"%(protocol)s://%(domain)s/"` |  |
| grafana."grafana.ini".server.serve_from_sub_path | bool | `true` |  |
| grafana.enabled | bool | `false` |  |
| grafana.ingress.enabled | bool | `true` |  |
| grafana.ingress.hosts[0] | string | `"grafana.<your-domain.com>"` |  |
| grafana.ingress.path | string | `"/"` |  |
| grafana.ingress.tls[0].hosts[0] | string | `"grafana.<your-domain.com>"` |  |
| grafana.ingress.tls[0].secretName | string | `"prod-ingress"` |  |
| grafana.persistence.enabled | bool | `true` |  |
| grafana.persistence.size | string | `"2Gi"` |  |
| grafana.persistence.storageClassName | string | `"microk8s-hostpath"` |  |
| grafana.persistence.type | string | `"pvc"` |  |
| imagePullSecrets[0].name | string | `"regcred"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `true` |  |
| ingress.hosts[0].host | string | `"studio.<your-domain.com>"` |  |
| ingress.image.pullPolicy | string | `"Always"` |  |
| ingress.image.repository | string | `"scaleoutsystems/ingress:develop"` |  |
| ingress.tls[0].hosts[0] | string | `"studio.<your-domain.com>"` |  |
| ingress.tls[0].secretName | string | `"prod-ingress"` |  |
| labs.ingress.secretName | string | `"prod-ingress"` |  |
| loki-stack.enabled | bool | `false` |  |
| namespace | string | `"default"` |  |
| postgresql-ha.enabled | bool | `false` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `""` |  |
| postgresql.fullnameOverride | string | `"stackn-studio-postgres"` |  |
| postgresql.persistence.accessModes[0] | string | `"ReadWriteMany"` |  |
| postgresql.persistence.enabled | bool | `true` |  |
| postgresql.persistence.size | string | `"20Gi"` |  |
| postgresql.persistence.storageClass | string | `"microk8s-hostpath"` |  |
| postgresql.postgresqlDatabase | string | `"stackn"` |  |
| postgresql.postgresqlPassword | string | `""` |  |
| postgresql.postgresqlUsername | string | `"stackn"` |  |
| prometheus.enabled | bool | `false` |  |
| prometheus.server.ingress.enabled | bool | `true` |  |
| prometheus.server.ingress.hosts[0] | string | `"prometheus.<your-domain.com>"` |  |
| prometheus.server.ingress.tls[0].hosts[0] | string | `"prometheus.<your-domain.com>"` |  |
| prometheus.server.ingress.tls[0].secretName | string | `"prod-ingress"` |  |
| prometheus.server.persistentVolume.size | string | `"2Gi"` |  |
| prometheus.server.persistentVolume.storageClass | string | `"microk8s-hostpath"` |  |
| rabbit.password | string | `""` |  |
| rabbit.username | string | `"admin"` |  |
| reloader.enabled | bool | `true` |  |
| reloader.namespace | string | `"default"` |  |
| reloader.reloader.watchGlobally | bool | `false` |  |
| service.type | string | `"ClusterIP"` |  |
| storageClassName | string | `"microk8s-hostpath"` |  |
| studio.debug | bool | `true` |  |
| studio.init | bool | `true` |  |
| studio.kubeconfig_file | string | `/app/chartcontroller/kubeconfig/config` |  |
| studio.kubeconfig_dir | string | `/app/chartcontroller/kubeconfig/` |  |
| studio.image.pullPolicy | string | `"Always"` |  |
| studio.image.repository | string | `"ghcr.io/scaleoutsystems/stackn/studio:develop"` |  |
| studio.media.storage.accessModes | string | `"ReadWriteMany"` |  |
| studio.media.storage.size | string | `"5Gi"` |  |
| studio.media.storage.storageClassName | string | `"microk8s-hostpath"` |  |
| studio.replicas | int | `1` |  |
| studio.resources.limits.cpu | string | `"1000m"` |  |
| studio.resources.limits.memory | string | `"4Gi"` |  |
| studio.resources.requests.cpu | string | `"400m"` |  |
| studio.resources.requests.memory | string | `"2Gi"` |  |
| studio.servicename | string | `"studio"` |  |
| studio.static.image | string | `"ghcr.io/scaleoutsystems/stackn/ingress:develop"` |  |
| studio.static.replicas | int | `1` |  |
| studio.static.resources.limits.cpu | int | `1` |  |
| studio.static.resources.limits.memory | string | `"512Mi"` |  |
| studio.static.resources.requests.cpu | string | `"100m"` |  |
| studio.static.resources.requests.memory | string | `"256Mi"` |  |
| studio.storage.StorageClassName | string | `"microk8s-hostpath"` |  |
| studio.storage.size | string | `"2Gi"` |  |
| studio.superUser | string | `"admin"` |  |
| studio.superuserEmail | string | `"admin@test.com"` |  |
| studio.superuserPassword | string | `""` |  |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Morgan Ekmefjord | morgan@scaleoutsystems.com |  |
| Fredrik Wrede | fredrik@scaleoutsystems.com |  |
