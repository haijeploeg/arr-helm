{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "piratestack.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sonarr.selectorLabels" -}}
app.kubernetes.io/app: sonarr
{{- end }}

{{- define "radarr.selectorLabels" -}}
app.kubernetes.io/app: radarr
{{- end }}

{{- define "bazarr.selectorLabels" -}}
app.kubernetes.io/app: bazarr
{{- end }}

{{- define "prowlarr.selectorLabels" -}}
app.kubernetes.io/app: prowlarr
{{- end }}

{{- define "sabnzbd.selectorLabels" -}}
app.kubernetes.io/app: sabnzbd
{{- end }}

{{- define "overseerr.selectorLabels" -}}
app.kubernetes.io/app: overseerr
{{- end }}

{{- define "tautulli.selectorLabels" -}}
app.kubernetes.io/app: tautulli
{{- end }}

{{- define "maintainerr.selectorLabels" -}}
app.kubernetes.io/app: maintainerr
{{- end }}

{{/*
Automatic pod affinity for co-locating downloads-using pods on the same node when using RWO.
Includes the affinity: key so the call site needs no extra if-check.
*/}}
{{- define "piratestack.downloadsAffinity" -}}
{{- if has "ReadWriteOnce" .Values.shared.storage.downloads.accessModes }}
affinity:
  podAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
    - labelSelector:
        matchLabels:
          piratestack/uses-downloads: "true"
          app.kubernetes.io/instance: {{ .Release.Name }}
      topologyKey: kubernetes.io/hostname
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "piratestack.labels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ include "piratestack.chart" . }}
{{- end }}
