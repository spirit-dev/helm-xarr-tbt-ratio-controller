{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "tbt-ratio-controller.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "tbt-ratio-controller.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "tbt-ratio-controller.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create TBT Ratio Controller app version
*/}}
{{- define "tbt-ratio-controller.defaultTag" -}}
{{- default .Chart.AppVersion .Values.image.tag }}
{{- end -}}

{{/*
Return valid version label
*/}}
{{- define "tbt-ratio-controller.versionLabelValue" -}}
{{ regexReplaceAll "[^-A-Za-z0-9_.]" (include "tbt-ratio-controller.defaultTag" .) "-" | trunc 63 | trimAll "-" | trimAll "_" | trimAll "." | quote }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "tbt-ratio-controller.labels" -}}
helm.sh/chart: {{ include "tbt-ratio-controller.chart" . }}
{{ include "tbt-ratio-controller.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: rustatio
app.kubernetes.io/version: {{ include "tbt-ratio-controller.versionLabelValue" . }}
{{- with .Values.additionalLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "tbt-ratio-controller.selectorLabels" -}}
{{- if .name -}}
app.kubernetes.io/name: {{ include "tbt-ratio-controller.name" . }}-{{ .name }}
{{ end -}}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
