# overseerr

Request management and media discovery tool for the Plex ecosystem.

> This chart is not maintained by the upstream project. Bugs in the application needs to be filled in the upstream project. Issues about the helm chart can be filled in this repository.

## TL;DR

```bash
helm repo add arr-helm https://haijeploeg.github.io/arr-helm/
helm repo update
helm install overseerr arr-helm/overseerr
```

## Install

```bash
helm install overseerr arr-helm/overseerr -f values.yaml
```

## Uninstall

```bash
helm uninstall overseerr
```

## Values

See `values.yaml` for a full list of all the options. Below are the most important values listed.

| Key | Type | Default | Description |
| --- | --- | --- | --- |
| `config.apikeySecret` | `string` | `N/A` | The existing secret containing the api key. The key should be `apikey` |
| `config.tz` | `string` | `Europe/Amsterdam` | The timezone |
| `image.pullPolicy` | `string` | `Always` | The `imagePullPolicy` setting |
| `image.repository` | `string` | `ghcr.io/onedr0p/overseerr-develop` | The image to use |
| `image.tag` | `string` | `rolling` | The tag of the image to use |
| `ingress.annotations` | `dict` | `{}` | Annotations for the ingress |
| `ingress.host` | `string` | `""` | The hostname to run the application |
| `ingress.ingressClassName` | `string` | `nginx` | The className of the ingress |
| `ingress.tls` | `list` | `[]` | TLS settings for the ingress |
| `storage.config.storage` | `string` | `5Gi` | The amount of storage mounted on the configuration folder |

## Changelog

### Version 1.0.0

#### Added

- Initial release of overseerr
