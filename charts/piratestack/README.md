# piratestack

A full media stack for your homelab — bundles Sonarr, Radarr, Bazarr, Prowlarr, Sabnzbd, Tautulli and Maintainerr into a single Helm release.

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
| `shared.storage.movies.existingClaim` | `string` | `""` | Use an existing PVC for movies (skips NFS config) |
| `shared.storage.movies.nfs.server` | `string` | `""` | NFS server for movies storage |
| `shared.storage.movies.nfs.path` | `string` | `""` | NFS path for movies storage |
| `shared.storage.tv.existingClaim` | `string` | `""` | Use an existing PVC for TV (skips NFS config) |
| `shared.storage.tv.nfs.server` | `string` | `""` | NFS server for TV storage |
| `shared.storage.tv.nfs.path` | `string` | `""` | NFS path for TV storage |

A note on downloads storage: keep this on fast local storage — not NFS. With a 1Gbps uplink (~100MB/s), if Sabnzbd is downloading at 70MB/s, only 30MB/s is left for unpacking. When Sonarr/Radarr then also needs to move files over that same uplink, things get slow fast. Use NFS only for the final movies/tv destinations.

`ReadWriteMany` (RWX) is the simplest option and works across nodes. `ReadWriteOnce` (RWO) works too — as long as Sonarr, Radarr, and Sabnzbd all run on the same node. When `ReadWriteOnce` is set, the chart automatically injects a `podAffinity` rule to ensure those three pods are co-located.

### Per-service

Every service supports the same set of options. Replace `<service>` with one of: `sonarr`, `radarr`, `bazarr`, `prowlarr`, `sabnzbd`, `tautulli`, `maintainerr`.

| Key | Type | Default | Description |
| --- | --- | --- | --- |
| `<service>.enable` | `bool` | `true` | Whether to deploy this service |
| `<service>.image.repository` | `string` | varies | Container image |
| `<service>.image.tag` | `string` | varies | Image tag |
| `<service>.image.pullPolicy` | `string` | `Always` | Image pull policy |
| `<service>.service.port` | `int` | varies | Service port |
| `<service>.service.type` | `string` | `ClusterIP` | Service type |
| `<service>.ingress.enabled` | `bool` | `false` | Whether to create an Ingress resource |
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
    enabled: true
    host: sonarr.example.com
    tls:
      - hosts:
          - sonarr.example.com
        secretName: sonarr-tls-secret

radarr:
  ingress:
    enabled: true
    host: radarr.example.com

maintainerr:
  enable: false
```

## Changelog

### 2.0.1

- **Fix: Pod affinity not working with RWO downloads** — Pods were missing the `app.kubernetes.io/instance` label in their pod template, causing the auto-injected `podAffinity` rule to never match any node. Sonarr, Radarr and Sabnzbd pod templates now include the standard Helm instance label so co-location works correctly.

### 2.0.0

- **Breaking: Removed Overseerr** — Overseerr is deprecated and no longer maintained. Use the [Seerr](https://github.com/seerr-team/seerr) chart instead, which is a drop-in successor with its own Helm chart.
- **Breaking: Ingress disabled by default** — `<service>.ingress.enabled` now defaults to `false`. If you were relying on the Ingress being created automatically, add `ingress.enabled: true` to your values for each service that needs it.
- **New: Flexible movies/tv storage** — Added `shared.storage.movies.existingClaim` and `shared.storage.tv.existingClaim`. When set, the chart uses that PVC instead of an NFS mount, allowing any storage backend (CIFS, iSCSI, etc.). NFS config remains fully supported.
