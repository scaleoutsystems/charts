{{/*
Return postgres host
*/}}
{{- define "stackn.postgres.host" -}}
{{- if .Values.postgresql.enabled }}
    {{- .Values.postgresql.fullnameOverride -}}
{{- else -}}
    {* HOLDER FOR HA MODE IN FUTURE RELEASE *}
{{- end -}}
{{- end -}}

{{/*
Return postgres DB name
*/}}
{{- define "stackn.postgres.name" -}}
{{- if .Values.postgresql.enabled }}
    {{- .Values.postgresql.postgresqlDatabase -}}
{{- else -}}
    {* HOLDER FOR HA MODE IN FUTURE RELEASE *}
{{- end -}}
{{- end -}}

{{/*
Return postgres port
*/}}
{{- define "stackn.postgres.port" -}}
{{- if .Values.postgresql.enabled }}
    {{- .Values.postgresql.service.port -}}
{{- else -}}
    {* HOLDER FOR HA MODE IN FUTURE RELEASE *}
{{- end -}}
{{- end -}}

{{/*
Return postgres user
*/}}
{{- define "stackn.postgres.user" -}}
{{- if .Values.postgresql.enabled }}
    {{- .Values.postgresql.postgresqlUsername -}}
{{- else -}}
    {* HOLDER FOR HA MODE IN FUTURE RELEASE *}
{{- end -}}
{{- end -}}

{{/*
Return postgres secret
*/}}
{{- define "stackn.postgres.secretName" -}}
{{- if .Values.postgresql.enabled }}
    {{- include "postgresql.secretName" .Subcharts.postgresql -}}
{{- else -}}
    {* HOLDER FOR HA MODE IN FUTURE RELEASE *}
{{- end -}}
{{- end -}}


