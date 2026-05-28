{{/*
Expand the name of the chart.
*/}}
{{- define "relution.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "relution.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "relution.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "relution.labels" -}}
helm.sh/chart: {{ include "relution.chart" . }}
{{ include "relution.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "relution.selectorLabels" -}}
app.kubernetes.io/name: {{ include "relution.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "relution.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "relution.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "relution-smg.labels" -}}
helm.sh/chart: {{ include "relution.chart" . }}
{{ include "relution-smg.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Values.smg.image.tag | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "relution-smg.selectorLabels" -}}
app.kubernetes.io/name: {{ include "relution.name" . }}-smg
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "relution-smg.serviceAccountName" -}}
{{- if .Values.smg.serviceAccount.create }}
{{- default (printf "%s-smg" (include "relution.fullname" .)) .Values.smg.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.smg.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Render the ingressRoute.defaultRoute match expression without route-specific path filters.
*/}}
{{- define "relution.ingressRoute.defaultRouteMatch" -}}
{{- $root := . -}}
{{- $route := .Values.ingressRoute.defaultRoute -}}
{{- if $route.match -}}
{{ tpl $route.match $root }}
{{- else if $route.hosts -}}
Host(`{{ tpl (index $route.hosts 0) $root }}`)
{{- range (slice $route.hosts 1) }} || Host(`{{ tpl . $root }}`)
{{- end -}}
{{- else -}}
Host(`{{ tpl $route.host $root }}`)
{{- end -}}
{{- end }}
