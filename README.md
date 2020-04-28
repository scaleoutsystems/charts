

This repository contains Helm charts maintained by scaleout systems. The repo index is hosted by GitHub pages.

## Getting started
To be able to deploy Helm chrats from this repository you first need to add this repository as a source of charts.

```bash
$ helm repo add scaleout https://scaleoutsystems.github.io/charts
```

Deploy a chart
```bash
$ helm install --name studio --namespace your-namespace --set domain=your.domain.name scaleout/studio
```


## License
