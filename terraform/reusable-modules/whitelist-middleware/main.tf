resource "kubectl_manifest" "whitelist_ip_middleware" {
  yaml_body = <<-EOF
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: ${var.name}
  namespace: ${var.namespace}
spec:
  ipWhiteList:
    sourceRange: ${var.whitelist_ips}
EOF

}