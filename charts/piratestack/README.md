# piratestack

A full media stack for your homelab — bundles Sonarr, Radarr, Bazarr, Prowlarr, Sabnzbd, Overseerr, Tautulli and Maintainerr into a single Helm release.

> This chart is not maintained by the upstream projects. Bugs in the applications should be reported upstream. Issues with the chart itself can be submitted in this repository.

## Install

```bash
helm repo add haijeploeg https://haijeploeg.github.io/charts/
helm repo update
helm install piratestack haijeploeg/piratestack -f values.yaml
```

## Uninstall

```bash
helm uninstall piratestack
```

## Values

See `values.yaml` for the full list of options. Below are the most important ones.

### Shared

These values are shared across all services.

| Key | Type | Default | Description |
| --- | --- | --- | --- |
| `shared.config.tz` | `string` | `Europe/Amsterdam` | Timezone for all services |
| `shared.config.puid` | `int` | `1057` | User ID for linuxserver.io containers |
| `shared.config.pgid` | `int` | `1057` | Group ID for linuxserver.io containers |
| `shared.storage.downloads.storage` | `string` | `500Gi` | Size of the shared downloads PVC |
| `shared.storage.downloads.accessModes` | `list` | `[ReadWriteMany]` | Access mode for the downloads PVC |
| `shared.storage.movies.nfs.server` | `string` | `""` | NFS server for movies storage |
| `shared.storage.movies.nfs.path` | `string` | `""` | NFS path for movies storage |
| `shared.storage.tv.nfs.server` | `string` | `""` | NFS server for TV storage |
| `shared.storage.tv.nfs.path` | `string` | `""` | NFS path for TV storage |

A note on downloads storage: use a local SSD-backed RWX PVC here, not NFS. With a 1Gbps uplink (~100MB/s), if Sabnzbd is downloading at 70MB/s, only 30MB/s is left for unpacking. When Sonarr/Radarr then also needs to move files over that same uplink, things get slow fast. Keep downloads local and use NFS only for the final movies/tv destinations.

### Per-service

Every service supports the same set of options. Replace `<service>` with one of: `sonarr`, `radarr`, `bazarr`, `prowlarr`, `sabnzbd`, `overseerr`, `tautulli`, `maintainerr`.

| Key | Type | Default | Description |
| --- | --- | --- | --- |
| `<service>.enable` | `bool` | `true` | Whether to deploy this service |
| `<service>.image.repository` | `string` | varies | Container image |
| `<service>.image.tag` | `string` | varies | Image tag |
| `<service>.image.pullPolicy` | `string` | `Always` | Image pull policy |
| `<service>.service.port` | `int` | varies | Service port |
| `<service>.service.type` | `string` | `ClusterIP` | Service type |
| `<service>.ingress.host` | `string` | `""` | Hostname for the ingress |
| `<service>.ingress.ingressClassName` | `string` | `nginx` | Ingress class |
| `<service>.ingress.annotations` | `dict` | `{}` | Ingress annotations |
| `<service>.ingress.tls` | `list` | `[]` | TLS configuration |
| `<service>.storage.config.storage` | `string` | `5Gi` | Size of the config PVC |
| `<service>.resources.requests.cpu` | `string` | `100m` | CPU request |
| `<service>.resources.requests.memory` | `string` | `128Mi` | Memory request |
| `<service>.securityContext.statefulSet` | `dict` | `{}` | Pod-level security context |
| `<service>.securityContext.pod` | `dict` | `{}` | Container-level security context |
| `<service>.nodeSelector` | `dict` | `{}` | Node selector |
| `<service>.tolerations` | `list` | `[]` | Tolerations |
| `<service>.affinity` | `dict` | `{}` | Affinity rules |

For Sonarr, Radarr, Prowlarr and Sabnzbd you can also reference an existing secret containing the API key:

```yaml
sonarr:
  config:
    apikeySecret: sonarr-apikey  # secret must have an 'apikey' key
```

### Example values.yaml

```yaml
shared:
  config:
    tz: Europe/Amsterdam
    puid: 1000
    pgid: 1000
  storage:
    downloads:
      storage: 200Gi
    movies:
      nfs:
        server: 192.168.1.10
        path: /mnt/nas/movies
    tv:
      nfs:
        server: 192.168.1.10
        path: /mnt/nas/tv

sonarr:
  ingress:
    host: sonarr.example.com
    tls:
      - hosts:
          - sonarr.example.com
        secretName: sonarr-tls-secret

radarr:
  ingress:
    host: radarr.example.com

maintainerr:
  enable: false
```
