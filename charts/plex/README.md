# plex

A Helm chart for deploying the Plex Personal Media Server(PMS) server.

> This chart is not maintained by the upstream project. Bugs in the application needs to be filled in the upstream project. Issues about the helm chart can be filled in this repository.

## TL;DR

```bash
helm repo add arr-helm https://haijeploeg.github.io/arr-helm/
helm repo update
helm install plex arr-helm/plex
```

## Install

```bash
helm install plex arr-helm/plex -f values.yaml
```

## Uninstall

```bash
helm uninstall plex
```

## Values

See `values.yaml` for a full list of all the options. Below are the most important values listed.

| Key | Type | Default | Description |
| --- | --- | --- | --- |
| `config.apikeySecret` | `string` | `N/A` | The existing secret containing the api key. The key should be `apikey` |
| `config.advertiseUrl` | `string` | `N/A` | The advertise URLs of Plex, comma seperated |
| `config.noAuthNetworks` | `string` | `N/A` | Comma seperated list of networks that can unauthenticated make connection to plex |
| `config.claimTokenSecret` | `string` | `N/A` | Name of the secret that contains the PLEX_CLAIM_TOKEN from [https://plex.tv/claim](https://plex.tv/claim). The secret should contain a key `token`. |
| `config.tz` | `string` | `Europe/Amsterdam` | The timezone |
| `image.pullPolicy` | `string` | `Always` | The `imagePullPolicy` setting |
| `image.repository` | `string` | `ghcr.io/onedr0p/plex-develop` | The image to use |
| `image.tag` | `string` | `rolling` | The tag of the image to use |
| `ingress.annotations` | `dict` | `{}` | Annotations for the ingress |
| `ingress.host` | `string` | `""` | The hostname to run the application |
| `ingress.ingressClassName` | `string` | `nginx` | The className of the ingress |
| `ingress.tls` | `list` | `[]` | TLS settings for the ingress |
| `service.nodePort.annotations` | `dict` | `N/A` | Annotations for the nodeport service, e.g. metallb |
| `storage.config.storage` | `string` | `5Gi` | The amount of storage mounted on the configuration folder |
| `storage.movies.nfs.path` | `string` | `""` | The fqdn to the server hosting the NFS share |
| `storage.movies.nfs.path` | `string` | `""` | The path on the NFS server that holds the movies |
| `storage.tv.nfs.path` | `string` | `""` | The fqdn to the server hosting the NFS share |
| `storage.tv.nfs.path` | `string` | `""` | The path on the NFS server that holds the tv shows |


## Changelog

### Version 1.0.0

#### Added

- Initial release of plex