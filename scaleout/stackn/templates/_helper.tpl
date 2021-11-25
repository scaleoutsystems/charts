{{/*
Return true if a secret object should be created
*/}}
{{- define "stackn.createSecret" -}}
{{- if not (include "stackn.useExistingSecret" .) -}}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return true if we should use an existingSecret.
*/}}
{{- define "stackn.useExistingSecret" -}}
{{- if or .Values.global.existingSecret .Values.existingSecret -}}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Get the password secret.
*/}}
{{- define "stackn.secretName" -}}
{{- if .Values.global.existingSecret }}
    {{- printf "%s" (tpl .Values.global.existingSecret $) -}}
{{- else if .Values.existingSecret -}}
    {{- printf "%s" (tpl .Values.existingSecret $) -}}
{{- else -}}
    stackn
{{- end -}}
{{- end -}}

{{/*
Return STACKn studio superuser
*/}}
{{- define "stackn.studio.superuser" -}}
{{- if .Values.global.studio.superUser }}
    {{- .Values.global.studio.superUser -}}
{{- else if .Values.studio.superUser -}}
    {{- .Values.studio.superUser -}}
{{- else -}}
    admin
{{- end -}}
{{- end -}}

{{/*
Return STACKn studio superuser password
*/}}
{{- define "stackn.studio.superuser.password" -}}
{{- if .Values.global.studio.superuserPassword }}
    {{- .Values.global.studio.superuserPassword -}}
{{- else if .Values.studio.superuserPassword -}}
    {{- .Values.studio.superuserPassword -}}
{{- else -}}
    {{- randAlphaNum 10 -}}
{{- end -}}
{{- end -}}

{{/*
Return STACKn studio superuser email
*/}}
{{- define "stackn.studio.superuser.email" -}}
{{- if .Values.global.studio.superuserEmail }}
    {{- .Values.global.studio.superuserEmail -}}
{{- else if .Values.studio.superuserEmail -}}
    {{- .Values.studio.superuserEmail -}}
{{- else -}}
    admin@test.com
{{- end -}}
{{- end -}}


{{/*
Get the password secret.
*/}}
{{- define "stackn.studio.postgresql.secretName" -}}
{{- if .Values.postgresql.existingSecret -}}
    {{- printf "%s" (tpl .Values.existingSecret $) -}}
{{- else -}}
    {{- printf "%s" .Values.postgresql.fullnameOverride  -}}
{{- end -}}
{{- end -}}


{{/*
Return STACKn rabbit password
*/}}
{{- define "stackn.rabbit.password" -}}
{{- if .Values.rabbit.password -}}
    {{- .Values.rabbit.password -}}
{{- else -}}
    {{- randAlphaNum 10 -}}
{{- end -}}
{{- end -}}

{{/*
Return STACKn rabbit username
*/}}
{{- define "stackn.rabbit.username" -}}
{{- if .Values.rabbit.username -}}
    {{- .Values.rabbit.username -}}
{{- else -}}
    admin
{{- end -}}
{{- end -}}

{{/*
Return STACKn oidc client secret
*/}}
{{- define "stackn.oidc.clientsecret" -}}
{{- if .Values.oidc.client_secret }}
    {{- .Values.oidc.client_secret -}}
{{- else -}}
    a-client-secret
{{- end -}}
{{- end -}}
