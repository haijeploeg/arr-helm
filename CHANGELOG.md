# Changelog

## piratestack

### 2.0.1

- **Fix: Pod affinity not working with RWO downloads** — Pods were missing the `app.kubernetes.io/instance` label in their pod template, causing the auto-injected `podAffinity` rule to never match any node. Sonarr, Radarr and Sabnzbd pod templates now include the standard Helm instance label so co-location works correctly.

### 2.0.0

- **Breaking: Removed Overseerr** — Overseerr is deprecated and no longer maintained. Use the [Seerr](https://github.com/seerr-team/seerr) chart instead, which is a drop-in successor with its own Helm chart.
- **Breaking: Ingress disabled by default** — `<service>.ingress.enabled` now defaults to `false`. If you were relying on the Ingress being created automatically, add `ingress.enabled: true` to your values for each service that needs it.
- **New: Flexible movies/tv storage** — Added `shared.storage.movies.existingClaim` and `shared.storage.tv.existingClaim`. When set, the chart uses that PVC instead of an NFS mount, allowing any storage backend (CIFS, iSCSI, etc.). NFS config remains fully supported.
