terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.13.2"
    }
  }
}

resource "kubectl_manifest" "kubernetes_ingress" {
  yaml_body = <<EOF
apiVersion: actions.summerwind.dev/v1alpha1
kind: RunnerDeployment
metadata:
  name: runner-${var.repo_name}
  namespace: ${var.namespace}
spec:
  replicas: ${var.replicas}
  template:
    spec:
      repository: ${var.repo_owner}/${var.repo_name}
      env:
        - name: DOCKERHUB_USERNAME
          valueFrom:
            secretKeyRef:
              name: docker-hub
              key: username
        - name: DOCKERHUB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: docker-hub
              key: password
EOF
}