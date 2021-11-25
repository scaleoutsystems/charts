STACKn
======

## Description

A Helm chart for deploying STACKn by Scaleout

Current chart version is 0.1.0

## Chart Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | postgresql | 10.4.2 |
| https://charts.bitnami.com/bitnami | postgresql-ha | 7.3.0 |
| https://grafana.github.io/helm-charts | grafana | 6.8.4 |
| https://grafana.github.io/helm-charts | loki-stack | 2.3.1 |
| https://prometheus-community.github.io/helm-charts | prometheus | 13.8.0 |
| https://stakater.github.io/stakater-charts | reloader | v0.0.86 |

## Configuration

You will need to change some of the default values:

`<your-domain.com>` should be replaced with your actual domain name everywhere.

`cluster_config` should be updated with the config file for your cluster. You need to have admin access to the namespace in which STACKn is to be deployed.

You might have to update `storageClassName`, `storageClass`, and `namespace`, depending on your cluster setup.

## Deploy locally without SSL certificates
For local testing/development set `oidc.verify = false`, this will enable insecure options in STACKn without certificates.
## Deploy an SSL certificate

For production you need a domain name with a wildcard SSL certificate. If your domain is your-domain.com, you will need a certificate for *.your-domain.com and *.studio.your-domain.com. Assuming that your certificate is fullchain.pem and your private key privkey.pem, you can create a secret `prod-ingress` containing the certificate with the command:
```
kubectl create secret tls prod-ingress --cert fullchain.pem --key privkey.pem
```

## Global values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.existingSecret | string | `""` |  |
| global.storageClass | string | `"microk8s-hostpath"` |  |
| global.studio.superUser | string | `""` |  |
| global.studio.superuserEmail | string | `""` |  |
| global.studio.superuserPassword | string | `""` |  |

## Values

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
| cluster_config | string | `""` | Config file for your cluster. Should allow admin access for your namespace. |
| docker-registry.enabled | bool | `false` |  |
| docker-registry.ingress.enabled | bool | `true` |  |
| docker-registry.ingress.hosts[0] | string | `"registry.<your-domain.com>"` |  |
| docker-registry.ingress.tls[0].hosts[0] | string | `"registry.<your-domain.com>"` |  |
| docker-registry.ingress.tls[0].secretName | string | `"prod-ingress"` |  |
| docker-registry.persistence.accessMode | string | `"ReadWriteOnce"` |  |
| docker-registry.persistence.enabled | bool | `true` |  |
| docker-registry.persistence.size | string | `"2Gi"` |  |
| docker-registry.persistence.storageClass | string | `"microk8s-hostpath"` |  |
| domain | string | `"studio.<your-domain.com>"` |  |
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
| studio.image.pullPolicy | string | `"Always"` |  |
| studio.image.repository | string | `"scaleoutsystems/studio:develop"` |  |
| studio.media.storage.accessModes | string | `"ReadWriteMany"` |  |
| studio.media.storage.size | string | `"5Gi"` |  |
| studio.media.storage.storageClassName | string | `"microk8s-hostpath"` |  |
| studio.replicas | int | `1` |  |
| studio.resources.limits.cpu | string | `"1000m"` |  |
| studio.resources.limits.memory | string | `"4Gi"` |  |
| studio.resources.requests.cpu | string | `"400m"` |  |
| studio.resources.requests.memory | string | `"2Gi"` |  |
| studio.servicename | string | `"studio"` |  |
| studio.static.image | string | `"scaleoutsystems/ingress:develop"` |  |
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
| Matteo Carone | matteo@scaleoutsystems.com |  |
