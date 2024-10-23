# sonarr

Smart PVR for newsgroup and bittorrent users.

> This chart is not maintained by the upstream project. Bugs in the application needs to be filled in the upstream project. Issues about the helm chart can be filled in this repository.

## TL;DR

```bash
helm repo add arr-helm https://haijeploeg.github.io/arr-helm/
helm repo update
helm install sonarr arr-helm/sonarr
```

## Install

```bash
helm install sonarr arr-helm/sonarr -f values.yaml
```

## Uninstall

```bash
helm uninstall sonarr
```

## Values

See `values.yaml` for a full list of all the options. Below are the most important values listed.

| Key | Type | Default | Description |
| --- | --- | --- | --- |
| `config.apikeySecret` | `string` | `N/A` | The existing secret containing the api key. The key should be `apikey` |
| `config.tz` | `string` | `Europe/Amsterdam` | The timezone |
| `image.pullPolicy` | `string` | `Always` | The `imagePullPolicy` setting |
| `image.repository` | `string` | `linuxserver/sonarr` | The image to use |
| `image.tag` | `string` | `latest` | The tag of the image to use |
| `ingress.annotations` | `dict` | `{}` | Annotations for the ingress |
| `ingress.host` | `string` | `""` | The hostname to run the application |
| `ingress.ingressClassName` | `string` | `nginx` | The className of the ingress |
| `ingress.tls` | `list` | `[]` | TLS settings for the ingress |
| `postgres.database` | `string` | `N/A` | The name of the database |
| `postgres.enabled` | `bool` | `false` | Enable postgres backend |
| `postgres.existingSecret` | `string` | `N/A` | The name of the secret that holds the information of Postgres |
| `postgres.existingSecretDatabaseKey` | `string` | `N/A` | The key withing the `existingSecret` that holds the postgres host |
| `postgres.existingSecretHostKey` | `string` | `N/A` | The key withing the `existingSecret` that holds the postgres host |
| `postgres.existingSecretPasswordKey` | `string` | `N/A` | The key withing the `existingSecret` that holds the postgres password |
| `postgres.existingSecretPortKey` | `string` | `N/A` | The key withing the `existingSecret` that holds the postgres port |
| `postgres.existingSecretUserKey` | `string` | `N/A` | The key withing the `existingSecret` that holds the postgres username |
| `postgres.host` | `string` | `N/A` | Hostname of the postgres database |
| `postgres.password` | `string` | `N/A` | The postgres password |
| `postgres.port` | `string` | `N/A` | The port to connect to the database |
| `postgres.user` | `string` | `N/A` | The postgres username |
| `storage.config.storage` | `string` | `5Gi` | The amount of storage mounted on the configuration folder |
| `storage.downloads.nfs.path` | `string` | `""` | The fqdn to the server hosting the NFS share |
| `storage.downloads.nfs.path` | `string` | `""` | The path on the NFS server that holds the downloads |
| `storage.tv.nfs.path` | `string` | `""` | The fqdn to the server hosting the NFS share |
| `storage.tv.nfs.path` | `string` | `""` | The path on the NFS server that holds the tv shows |

### Postgres

As you can see in the values, PostgreSQL can be used as a database backend. Please note that this chart does not roll out a postgres instance. It only connects to an already existing PostgreSQL database using either an existing secret, or plain values. For example:

```yaml
postgres:
  enabled: true
  existingSecret: sonarr-postgres-secret
  existingSecretHostKey: host
  existingSecretPortKey: port
  existingSecretUserKey: username
  existingSecretPasswordKey: password
  existingSecretDatabaseKey: database
```

## Changelog

### Version 1.0.0

#### Added

- Initial release of sonarr