# radarr

Movie organizer/manager for usenet and torrent users.

> This chart is not maintained by the upstream project. Bugs in the application needs to be filled in the upstream project. Issues about the helm chart can be filled in this repository.

## TL;DR

```bash
helm repo add arr-helm https://haijeploeg.github.io/arr-helm/
helm repo update
helm install radarr arr-helm/radarr
```

## Values

See `values.yaml` for a full list of all the options. Below are the most important values listed.

| Key | Type | Default | Description |
| --- | --- | --- | --- |
| `image.tag` | `string` | `latest` | The tag of the image to use |
| `image.repository` | `string` | `linuxserver/radarr` | The image to use |
| `image.pullPolicy` | `string` | `Always` | The `imagePullPolicy` setting |
| `env.puid` | `string` | `"1000"` | The UID the run the application |
| `env.pgid` | `string` | `"1000"` | The GID the run the application |
| `env.tz` | `string` | `Europe/Amsterdam` | The timezone |
| `ingress.annotations` | `dict` | `{}` | Annotations for the ingress |
| `ingress.ingressClassName` | `string` | `nginx` | The className of the ingress |
| `ingress.host` | `string` | `""` | The hostname to run the application |
| `ingress.tls` | `list` | `[]` | TLS settings for the ingress |
| `storage.config.storage` | `string` | `5Gi` | The amount of storage mounted on the configuration folder |
| `storage.movies.storage` | `string` | `100Gi` | The amount of storage behind the NFS folder |
| `storage.movies.storageClassName` | `string` | `""` | The storageClass to use. Leave empty unless you know what you are doing! |
| `storage.movies.nfs.path` | `string` | `""` | The path on the NFS server that holds the movies |
| `storage.movies.nfs.path` | `string` | `""` | The fqdn to the server hosting the NFS share |
| `storage.downloads.storage` | `string` | `100Gi` | The amount of storage behind the NFS folder |
| `storage.downloads.storageClassName` | `string` | `""` | The storageClass to use. Leave empty unless you know what you are doing! |
| `storage.downloads.nfs.path` | `string` | `""` | The path on the NFS server that holds the downloads |
| `storage.downloads.nfs.path` | `string` | `""` | The fqdn to the server hosting the NFS share |

## Changelog

### Version 0.0.1

#### Added

- Initial release of radarr
