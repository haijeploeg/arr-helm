# Arr Helm charts

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

```bash
helm repo add arr-helm https://haijeploeg.github.io/arr-helm/
helm repo update
```

For example to install the `radarr` chart:

```bash
helm install radarr arr-helm/radarr
```

To uninstall the chart:

```bash
helm uninstall radarr
```
