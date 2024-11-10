# piratestack

A full stack that includes sonarr, radarr, bazarr, prowlarr, sabnzbd and overseerr

> This chart is not maintained by the upstream projects. Bugs in the application needs to be submitted in the upstream project. Issues about the helm chart can be submitted in this repository.

## TL;DR

```bash
helm repo add haijeploeg https://haijeploeg.github.io/charts/
helm repo update
helm install piratestack haijeploeg/piratestack
```

## Install

```bash
helm install piratestack haijeploeg/piratestack -f values.yaml
```

## Uninstall

```bash
helm uninstall piratestack
```

## Values

See `values.yaml` for a full list of all the options. Below are the most important values listed.

### General

General values contain values that are shared between all applications, for example (NFS) PVC's for movies, tv shows and downloads. Make sure the downloads PVC is a PVC on local SSD storage and not on an external NFS (although possible). Using an external NFS, assuming an uplink of 1GBps results in write speeds of abour 100MB/s. Whenever Sabnzbd is downloading with 70MB/s, that leaves an unpacking speed of 30MB/s. Whenever Radarr or Sonarr wants to move a download to a movies or tv shows folder, that also needs to go through the same uplink. Dropping speeds drastically.

Whenever a local storage RWX PVC is used on an SSD, Sabnzbd can utilize the full write speeds of the disk and Sonarr and Radarr can utilize the uplink to the external NFS fully.

| Key | Type | Default | Description |
| --- | --- | --- | --- |
| `general.storage.downloads.nfs.enable` | `bool` | `false` | Enable NFS storage for downloads, this disables other storage settings for downloads |
| `general.storage.downloads.nfs.server` | `string` | `N/A` | The fqdn/ip to the server hosting the NFS share |
| `general.storage.downloads.nfs.path` | `string` | `N/A` | The path to the downloads folder on the NFS server |
| `general.storage.downloads.storageClass` | `string` `""` | The storageClass to use, has to be ReadWriteMany |
| `general.storage.downloads.storage` | `string` `500Gi` | The amount of storage |
| `general.storage.movies.nfs.enable` | `bool` | `false` | Enable NFS storage for movies, this disables other storage settings for movies |
| `general.storage.movies.nfs.server` | `string` | `N/A` | The fqdn/ip to the server hosting the NFS share |
| `general.storage.movies.nfs.path` | `string` | `N/A` | The path to the movies folder on the NFS server |
| `general.storage.movies.storageClass` | `string` `""` | The storageClass to use, has to be ReadWriteMany |
| `general.storage.movies.storage` | `string` `500Gi` | The amount of storage |
| `general.storage.tv.nfs.enable` | `bool` | `false` | Enable NFS storage for tv, this disables other storage settings for tv |
| `general.storage.tv.nfs.server` | `string` | `N/A` | The fqdn/ip to the server hosting the NFS share |
| `general.storage.tv.nfs.path` | `string` | `N/A` | The path to the tv folder on the NFS server |
| `general.storage.tv.storageClass` | `string` `""` | The storageClass to use, has to be ReadWriteMany |
| `general.storage.tv.storage` | `string` `500Gi` | The amount of storage |
| `general.config.tz` | `string` | `Europe/Amsterdam` | The default timezone to use for all services |

To enable this add the `postgres.enable` key under the respectively service keys (`sonarr`, `radarr` or `prowlarr`) and fill in the details about the connection. Please note that this chart does not roll out a postgres instance. It only connects to an already existing PostgreSQL database using either an existing secret, or plain values. For example:

```yaml
sonarr:
  postgres:
    enabled: true
    existingSecret: sonarr-postgres-secret
    existingSecretHostKey: host
    existingSecretPortKey: port
    existingSecretUserKey: username
    existingSecretPasswordKey: password
    existingSecretDatabaseKey: database
```

### Sonarr

| Key | Type | Default | Description |
| --- | --- | --- | --- |
| `sonarr.enable` | `bool` | `true` | Wether or not to rollout Sonarr |
| `sonarr.config.apikeySecret` | `string` | `N/A` | The existing secret containing the api key. The key should be `apikey` |
| `sonarr.image.pullPolicy` | `string` | `Always` | The `imagePullPolicy` setting |
| `sonarr.image.repository` | `string` | `ghcr.io/onedr0p/sonarr-develop` | The image to use |
| `sonarr.image.tag` | `string` | `rolling` | The tag of the image to use |
| `sonarr.ingress.annotations` | `dict` | `{}` | Annotations for the ingress |
| `sonarr.ingress.host` | `string` | `""` | The hostname to run the application |
| `sonarr.ingress.ingressClassName` | `string` | `nginx` | The className of the ingress |
| `sonarr.ingress.tls` | `list` | `[]` | TLS settings for the ingress |

## Changelog

### Version 1.0.0

#### Added

- Initial release of piratestack