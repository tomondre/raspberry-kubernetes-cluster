#https://github.com/actions-runner-controller/actions-runner-controller/blob/master/QuickStartGuide.md
terraform {
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["actions-runner"]
    }
  }
}

provider "github" {
  token = var.github_token
}

provider "kubernetes" {
  config_path = "C:\\Users\\PC1\\.kube\\config"
}

resource "github_actions_secret" "notes_dockerhub_username" {
  repository  = "notes-website"
  secret_name = "DOCKERHUB_USERNAME"
  plaintext_value = var.dockerhub_username
}

resource "github_actions_secret" "notes_dockerhub_token" {
  repository  = "notes-website"
  secret_name = "DOCKERHUB_TOKEN"
  plaintext_value = var.dockerhub_token
}

resource "github_actions_secret" "notes_cloudflare_token" {
  repository = "notes-website"
  secret_name = "CLOUDFLARE_API_TOKEN"
  plaintext_value = var.cloudflare_api_token
}

resource "github_actions_secret" "notes_kubernetes_config_file" {
  repository = "notes-website"
  secret_name = "KUBE_CONFIG"
  plaintext_value = var.kube_config
}

resource "github_actions_secret" "notes_terraform_cloud_token" {
  repository  = "notes-website"
  secret_name = "TERRAFORM_TOKEN"
  plaintext_value = var.terraform_token
}

resource "github_actions_secret" "portfolio_dockerhub_username" {
  repository  = "portfolio-angular"
  secret_name = "DOCKERHUB_USERNAME"
  plaintext_value = var.dockerhub_username
}

resource "github_actions_secret" "portfolio_dockerhub_token" {
  repository  = "portfolio-angular"
  secret_name = "DOCKERHUB_TOKEN"
  plaintext_value = var.dockerhub_token
}

resource "github_actions_secret" "portfolio_cloudflare_token" {
  repository = "portfolio-angular"
  secret_name = "CLOUDFLARE_API_TOKEN"
  plaintext_value = var.cloudflare_api_token
}

resource "github_actions_secret" "portfolio_kubernetes_config_file" {
  repository = "portfolio-angular"
  secret_name = "KUBE_CONFIG"
  plaintext_value = var.kube_config
}

resource "github_actions_secret" "portfolio_terraform_cloud_token" {
  repository  = "portfolio-angular"
  secret_name = "TERRAFORM_TOKEN"
  plaintext_value = var.terraform_token
}

resource "github_actions_secret" "deployments_dockerhub_username" {
  repository  = "deployments"
  secret_name = "DOCKERHUB_USERNAME"
  plaintext_value = var.dockerhub_username
}

resource "github_actions_secret" "deployments_dockerhub_token" {
  repository  = "deployments"
  secret_name = "DOCKERHUB_TOKEN"
  plaintext_value = var.dockerhub_token
}

resource "github_actions_secret" "deployments_cloudflare_token" {
  repository = "deployments"
  secret_name = "CLOUDFLARE_API_TOKEN"
  plaintext_value = var.cloudflare_api_token
}

resource "github_actions_secret" "deployments_kubernetes_config_file" {
  repository = "deployments"
  secret_name = "KUBE_CONFIG"
  plaintext_value = var.kube_config
}

resource "github_actions_secret" "deployments_terraform_cloud_token" {
  repository  = "deployments"
  secret_name = "TERRAFORM_TOKEN"
  plaintext_value = var.terraform_token
}