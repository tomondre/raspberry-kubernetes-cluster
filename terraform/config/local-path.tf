//This resource is created by k3s by default but the reclaim policy defaults to "Delete"
//Therefore if you want to change the  policy, remove the current local-path storage class and apply this one.

resource "kubectl_manifest" "local-path-change" {
  yaml_body = <<-EOF
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-path
provisioner: rancher.io/local-path
volumeBindingMode: WaitForFirstConsumer
reclaimPolicy: Retain
EOF
}