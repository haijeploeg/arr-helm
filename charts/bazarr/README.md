# bazarr

Bazarr is a companion application to bazarr and Radarr. It manages and downloads subtitles based on your requirements. You define your preferences by TV show or movie and Bazarr takes care of everything for you.

> This chart is not maintained by the upstream project. Bugs in the application needs to be filled in the upstream project. Issues about the helm chart can be filled in this repository.

## TL;DR

```bash
helm repo add arr-helm https://haijeploeg.github.io/arr-helm/
helm repo update
helm install bazarr arr-helm/bazarr
```

## Install

```bash
helm install bazarr arr-helm/bazarr -f values.yaml
```

## Uninstall

```bash
helm uninstall bazarr
```

## Values

See `values.yaml` for a full list of all the options. Below are the most important values listed.

| Key | Type | Default | Description |
| --- | --- | --- | --- |
| `config.tz` | `string` | `Europe/Amsterdam` | The timezone |
| `image.pullPolicy` | `string` | `Always` | The `imagePullPolicy` setting |
| `image.repository` | `string` | `ghcr.io/onedr0p/bazarr` | The image to use |
| `image.tag` | `string` | `rolling` | The tag of the image to use |
| `ingress.annotations` | `dict` | `{}` | Annotations for the ingress |
| `ingress.host` | `string` | `""` | The hostname to run the application |
| `ingress.ingressClassName` | `string` | `nginx` | The className of the ingress |
| `ingress.tls` | `list` | `[]` | TLS settings for the ingress |
| `storage.config.storage` | `string` | `5Gi` | The amount of storage mounted on the configuration folder |
| `storage.movies.nfs.path` | `string` | `""` | The fqdn to the server hosting the NFS share |
| `storage.movies.nfs.path` | `string` | `""` | The path on the NFS server that holds the downloads |
| `storage.tv.nfs.path` | `string` | `""` | The fqdn to the server hosting the NFS share |
| `storage.tv.nfs.path` | `string` | `""` | The path on the NFS server that holds the tv shows |

## Changelog

### Version 1.0.0

#### Added

- Initial release of bazarr