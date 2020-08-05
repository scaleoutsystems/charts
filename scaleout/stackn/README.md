stackn
======

## Description

A Helm chart for deploying STACKn by Scaleout

Current chart version is 0.0.1

## Chart Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://codecentric.github.io/helm-charts | keycloak | 9.0.1 |
| https://kubernetes-charts.storage.googleapis.com | docker-registry | 1.9.1 |

## Configuration

You will need to change some of the default values:

`your-domain.com` should be replaced with your actual domain name everywhere.

<!-- `domain`, `ingress.hosts[0].host`, and `ingress.tls[0].hosts` should point to Studio and should be the same (e.g. studio.your-domain.com)

`keycloak.ingress.rules[0].host` needs to be updated with your domain, e.g. keycloak.your-domain.com. It should have the same value as `oidc.host`. -->

`cluster_config` should be updated with the config file for your cluster. You need to have admin access to the namespace in which STACKn is to be deployed.

You might have to update `storageClassName`, `storageClass`, and `namespace`, depending on your cluster setup.

## Deploy an SSL certificate

You need a domain name with a wildcard SSL certificate. If your domain is your-domain.com, you will need a certificate for *.your-domain.com and *.studio.your-domain.com. Assuming that your certificate is fullchain.pem and your private key privkey.pem, you can create a secret `prod-ingress` containing the certificate with the command:
```
kubectl create secret tls prod-ingress --cert fullchain.pem --key privkey.pem
```
An alternative is to deploy STACKn without a certificate, but you will then receive warnings from your browser, and the command-line tool will not work properly. To deploy without SSL, simply comment out the corresponding lines in your `values.yaml`.

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
| argo.ui.ingress.hosts[0] | string | `"workflow.your-domain.com"` |  |
| argo.ui.ingress.tls[0].hosts[0] | string | `"workflow.your-domain.com"` |  |
| argo.ui.ingress.tls[0].secretName | string | `"prod-ingress"` |  |
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
| docker-registry.ingress.enabled | bool | `false` |  |
| docker-registry.ingress.hosts[0] | string | `"registry.your-domain.com"` |  |
| docker-registry.ingress.tls[0].hosts[0] | string | `"registry.your-domain.com"` |  |
| docker-registry.ingress.tls[0].secretName | string | `"prod-ingress"` |  |
| docker-registry.persistence.accessMode | string | `"ReadWriteOnce"` |  |
| docker-registry.persistence.enabled | bool | `true` |  |
| docker-registry.persistence.size | string | `"4Gi"` |  |
| docker-registry.persistence.storageClass | string | `"microk8s-hostpath"` |  |
| domain | string | `"studio.your-domain.com"` | Domain name, should match ingress.hosts.host |
| fedn.enabled | bool | `false` |  |
| fixtures | string | `"[]"` |  |
| imagePullSecrets[0].name | string | `"regcred"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `true` |  |
| ingress.hosts[0].host | string | `"studio.your-domain.com"` | Ingress to Studio. Should match domain. setup TLS if you have a platform certificate or use 'tls-acme' if you have certbot deployed and want to generate a certificate. |
| ingress.image.pullPolicy | string | `"Always"` |  |
| ingress.image.repository | string | `"scaleoutsystems/ingress:master"` |  |
| ingress.tls[0].hosts[0] | string | `"studio.your-domain.com"` |  |
| ingress.tls[0].secretName | string | `"prod-ingress"` | The certificate should be a wildcard cert for *.your-domain.com and *.studio.your-domain.com |
| keycloak.extraEnv | string | `"- name: KEYCLOAK_IMPORT\n  value: /realm/realm.json\n- name: KEYCLOAK_USER\n  value: admin\n- name: KEYCLOAK_PASSWORD\n  value: password\n- name: PROXY_ADDRESS_FORWARDING\n  value: \"true\"\n"` |  |
| keycloak.extraVolumeMounts | string | `"- name: realm-secret\n  mountPath: \"/realm/\"\n  readOnly: true\n"` |  |
| keycloak.extraVolumes | string | `"- name: realm-secret\n  secret:\n    secretName: realm-secret\n"` |  |
| keycloak.ingress.enabled | bool | `true` |  |
| keycloak.ingress.rules[0].host | string | `"keycloak.your-domain.com"` |  |
| keycloak.ingress.rules[0].paths[0] | string | `"/"` |  |
| keycloak.ingress.tls[0].hosts[0] | string | `"keycloak.your-domain.com"` |  |
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
| labs.ingress.secretName | string | `"prod-ingress"` |  |
| namespace | string | `"default"` |  |
| nodeSelector | object | `{}` |  |
| oidc.client_id | string | `"studio"` |  |
| oidc.client_secret | string | `"a-client-secret"` |  |
| oidc.enabled | bool | `true` |  |
| oidc.host | string | `"https://keycloak.your-domain.com"` |  |
| oidc.realm | string | `"STACKn"` |  |
| oidc.sign_algo | string | `"RS256"` |  |
| openfaas.async | bool | `true` |  |
| openfaas.basic_auth | bool | `false` |  |
| openfaas.enabled | bool | `false` |  |
| openfaas.exposeServices | bool | `false` |  |
| openfaas.functionNamespace | string | `"stack-fn"` |  |
| openfaas.ingress.enabled | bool | `false` |  |
| openfaas.ingress.hosts[0].host | string | `"serve.your-domain.com"` |  |
| openfaas.ingress.hosts[0].path | string | `"/"` |  |
| openfaas.ingress.hosts[0].serviceName | string | `"gateway"` |  |
| openfaas.ingress.hosts[0].servicePort | int | `8080` |  |
| openfaas.ingress.tls[0].hosts[0] | string | `"serve.your-domain.com"` |  |
| openfaas.ingress.tls[0].secretName | string | `"prod-ingress"` |  |
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
| storageClassName | string | `"microk8s-hostpath"` |  |
| studio.image.pullPolicy | string | `"Always"` |  |
| studio.image.repository | string | `"scaleoutsystems/studio:master"` | Select which version of the chart controller to deploy, default is master branch. |
| studio.resources.limits.cpu | string | `"1000m"` |  |
| studio.resources.limits.memory | string | `"4Gi"` |  |
| studio.resources.requests.cpu | string | `"400m"` |  |
| studio.resources.requests.memory | string | `"2Gi"` |  |
| studio.servicename | string | `"studio"` |  |
| tolerations | list | `[]` |  |
