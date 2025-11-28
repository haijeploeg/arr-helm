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
Common labels
*/}}
{{- define "piratestack.labels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ include "piratestack.chart" . }}
{{- end }}
