stackn
======
A Helm chart for deploying STACKn by Scaleout

Current chart version is `0.0.1`



## Chart Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://codecentric.github.io/helm-charts | keycloak | 9.0.1 |
| https://kubernetes-charts.storage.googleapis.com | docker-registry | 1.9.1 |

## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| argo-events.enabled | bool | `false` |  |
| argo-events.installCRD | bool | `false` |  |
| argo-events.namespace | string | `"argo-events"` |  |
| argo-events.singleNamespace | bool | `false` |  |
| argo.enabled | bool | `false` |  |
| argo.installCRD | bool | `false` |  |
| argo.ui.ingress.annotations."nginx.ingress.kubernetes.io/proxy-body-size" | string | `"1000m"` |  |
| argo.ui.ingress.enabled | bool | `true` |  |
| argo.ui.ingress.hosts[0] | string | `"workflow.stack.your.domain.name"` |  |
| argo.ui.ingress.tls[0].hosts[0] | string | `"workflow.stack.your.domain.name"` |  |
| argo.ui.ingress.tls[0].secretName | string | `"ingress-secret"` |  |
| chartcontroller.branch | string | `"master"` |  |
| chartcontroller.image.pullPolicy | string | `"Always"` |  |
| chartcontroller.image.repository | string | `"scaleoutsystems/chart-controller:master"` |  |
| chartcontroller.resources.limits.cpu | string | `"200m"` |  |
| chartcontroller.resources.limits.memory | string | `"512Mi"` |  |
| chartcontroller.resources.requests.cpu | string | `"200m"` |  |
| chartcontroller.resources.requests.memory | string | `"512Mi"` |  |
| cluster_config | string | `"apiVersion: v1\nkind: Config\nclusters:\n- name: \"local\"\n  cluster:\n    server: \"your.server.here\"\nusers:\n- name: \"local\"\n  user:\n    token: \"your.token.here\"\n\ncontexts:\n- name: \"local\"\n  context:\n    user: \"local\"\n    cluster: \"local\"\n\ncurrent-context: \"local\""` | Config file for your cluster. Should allow admin access for your namespace. |
| docker-registry.enabled | bool | `true` |  |
| docker-registry.ingress.annotations."nginx.ingress.kubernetes.io/proxy-body-size" | string | `"5500m"` |  |
| docker-registry.ingress.enabled | bool | `true` |  |
| docker-registry.ingress.hosts[0] | string | `"registry.stack.your.domain.name"` |  |
| docker-registry.ingress.tls[0].hosts[0] | string | `"registry.stack.your.domain.name"` |  |
| docker-registry.ingress.tls[0].secretName | string | `"ingress-secret"` |  |
| docker-registry.persistence.accessMode | string | `"ReadWriteOnce"` |  |
| docker-registry.persistence.enabled | bool | `true` |  |
| docker-registry.persistence.size | string | `"4Gi"` |  |
| domain | string | `"studio.your.domain.name"` | Domain name, should match ingress.hosts.host |
| fedn.enabled | bool | `false` |  |
| fixtures | string | `"[]"` |  |
| imagePullSecrets[0].name | string | `"regcred"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `true` |  |
| ingress.hosts[0].host | string | `"studio.your.domain.name"` | Ingress to Studio. Should match domain. |
| ingress.image.pullPolicy | string | `"Always"` |  |
| ingress.image.repository | string | `"scaleoutsystems/ingress:master"` |  |
| keycloak.extraEnv | string | `"- name: KEYCLOAK_IMPORT\n  value: /realm/realm.json\n- name: KEYCLOAK_USER\n  value: admin\n- name: KEYCLOAK_PASSWORD\n  value: password\n- name: PROXY_ADDRESS_FORWARDING\n  value: \"true\"\n"` |  |
| keycloak.extraVolumeMounts | string | `"- name: realm-secret\n  mountPath: \"/realm/\"\n  readOnly: true\n"` |  |
| keycloak.extraVolumes | string | `"- name: realm-secret\n  secret:\n    secretName: realm-secret\n"` |  |
| keycloak.ingress.enabled | bool | `true` |  |
| keycloak.ingress.rules[0].host | string | `"keycloak.stack.your.domain.name"` |  |
| keycloak.ingress.rules[0].paths[0] | string | `"/"` |  |
| keycloak.ingress.tls[0].hosts[0] | string | `"keycloak.stack.your.domain.name"` |  |
| keycloak.ingress.tls[0].secretName | string | `"prod-ingress"` |  |
| keycloak.persistence.dbVendor | string | `"postgres"` |  |
| keycloak.persistence.deployPostgres | bool | `true` |  |
| keycloak.persistence.pullPolicy | string | `"Always"` |  |
| keycloak.postgresql.persistence.enabled | bool | `true` |  |
| keycloak.postgresql.persistence.size | string | `"1Gi"` |  |
| keycloak.postgresql.persistence.storageClass | string | `"microk8s-hostpath"` |  |
| keycloak.postgresql.postgresqlDatabase | string | `"keycloak"` |  |
| keycloak.postgresql.postgresqlPassword | string | `"db_password"` |  |
| keycloak.postgresql.postgresqlUsername | string | `"keycloak"` |  |
| labs.ingress.secretName | string | `"prod-ingress"` | The certificate should be a wildcard cert for *.your.domain.name and *.studio.your.domain.name |
| namespace | string | `"default"` |  |
| nodeSelector | object | `{}` |  |
| oidc.client_id | string | `"studio"` |  |
| oidc.client_secret | string | `"a-client-secret"` |  |
| oidc.enabled | bool | `false` |  |
| oidc.host | string | `"https://keycloak.stack.your.domain.name"` |  |
| oidc.realm | string | `"STACKn"` |  |
| oidc.sign_algo | string | `"RS256"` |  |
| openfaas.async | bool | `true` |  |
| openfaas.basic_auth | bool | `false` |  |
| openfaas.enabled | bool | `false` |  |
| openfaas.exposeServices | bool | `false` |  |
| openfaas.functionNamespace | string | `"stack-fn"` |  |
| openfaas.ingress.enabled | bool | `false` |  |
| openfaas.ingress.hosts[0].host | string | `"serve.stack.your.domain.name"` |  |
| openfaas.ingress.hosts[0].path | string | `"/"` |  |
| openfaas.ingress.hosts[0].serviceName | string | `"gateway"` |  |
| openfaas.ingress.hosts[0].servicePort | int | `8080` |  |
| openfaas.ingress.tls[0].hosts[0] | string | `"serve.stack.your.domain.name"` |  |
| openfaas.ingress.tls[0].secretName | string | `"ingress-secret"` |  |
| openfaas.operator.create | bool | `true` |  |
| openfaas.psp | bool | `false` |  |
| openfaas.rbac | bool | `false` |  |
| openfaas.securityContext | bool | `true` |  |
| postgres.db.name | string | `"postgres"` |  |
| postgres.db.password | string | `"postgres"` |  |
| postgres.db.user | string | `"postgres"` |  |
| postgres.resources.limits.cpu | string | `"400m"` |  |
| postgres.resources.limits.memory | string | `"2Gi"` |  |
| postgres.resources.requests.cpu | string | `"200m"` |  |
| postgres.resources.requests.memory | string | `"1Gi"` |  |
| rabbit.password | string | `"LJqEG9RE4FdZbVWoJzZIOQEI"` |  |
| rabbit.username | string | `"admin"` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| service.type | string | `"ClusterIP"` |  |
| storageClassName | string | `"hostpath"` |  |
| studio.image.pullPolicy | string | `"Always"` |  |
| studio.image.repository | string | `"scaleoutsystems/studio:master"` | Select which version of the chart controller to deploy, default is master branch. |
| studio.resources.limits.cpu | string | `"1000m"` |  |
| studio.resources.limits.memory | string | `"4Gi"` |  |
| studio.resources.requests.cpu | string | `"400m"` |  |
| studio.resources.requests.memory | string | `"2Gi"` |  |
| studio.servicename | string | `"studio"` |  |
| tolerations | list | `[]` |  |
