{{- if and (not .Values.relution.config) (not .Values.relution.environment) (not .Values.relution.secrets)  -}}
{{ fail "Please provide at least one of the following values: relution.config, relution.environment, relution.secrets" }}
{{- end -}}
