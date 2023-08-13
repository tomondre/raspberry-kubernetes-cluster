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
  repository      = "notes-website"
  secret_name     = "DOCKERHUB_USERNAME"
  plaintext_value = var.dockerhub_username
}

resource "github_actions_secret" "notes_dockerhub_token" {
  repository      = "notes-website"
  secret_name     = "DOCKERHUB_TOKEN"
  plaintext_value = var.dockerhub_token
}

resource "github_actions_secret" "notes_cloudflare_token" {
  repository      = "notes-website"
  secret_name     = "CLOUDFLARE_API_TOKEN"
  plaintext_value = var.cloudflare_api_token
}

resource "github_actions_secret" "notes_kubernetes_config_file" {
  repository      = "notes-website"
  secret_name     = "KUBE_CONFIG"
  plaintext_value = var.kube_config
}

resource "github_actions_secret" "notes_terraform_cloud_token" {
  repository      = "notes-website"
  secret_name     = "TERRAFORM_TOKEN"
  plaintext_value = var.terraform_token
}

resource "github_actions_secret" "portfolio_dockerhub_username" {
  repository      = "portfolio-angular"
  secret_name     = "DOCKERHUB_USERNAME"
  plaintext_value = var.dockerhub_username
}

resource "github_actions_secret" "portfolio_dockerhub_token" {
  repository      = "portfolio-angular"
  secret_name     = "DOCKERHUB_TOKEN"
  plaintext_value = var.dockerhub_token
}

resource "github_actions_secret" "portfolio_cloudflare_token" {
  repository      = "portfolio-angular"
  secret_name     = "CLOUDFLARE_API_TOKEN"
  plaintext_value = var.cloudflare_api_token
}

resource "github_actions_secret" "portfolio_kubernetes_config_file" {
  repository      = "portfolio-angular"
  secret_name     = "KUBE_CONFIG"
  plaintext_value = var.kube_config
}

resource "github_actions_secret" "portfolio_terraform_cloud_token" {
  repository      = "portfolio-angular"
  secret_name     = "TERRAFORM_TOKEN"
  plaintext_value = var.terraform_token
}

resource "github_actions_secret" "deployments_dockerhub_username" {
  repository      = "deployments"
  secret_name     = "DOCKERHUB_USERNAME"
  plaintext_value = var.dockerhub_username
}

resource "github_actions_secret" "deployments_dockerhub_token" {
  repository      = "deployments"
  secret_name     = "DOCKERHUB_TOKEN"
  plaintext_value = var.dockerhub_token
}

resource "github_actions_secret" "deployments_cloudflare_token" {
  repository      = "deployments"
  secret_name     = "CLOUDFLARE_API_TOKEN"
  plaintext_value = var.cloudflare_api_token
}

resource "github_actions_secret" "deployments_kubernetes_config_file" {
  repository      = "deployments"
  secret_name     = "KUBE_CONFIG"
  plaintext_value = var.kube_config
}

resource "github_actions_secret" "deployments_terraform_cloud_token" {
  repository      = "deployments"
  secret_name     = "TERRAFORM_TOKEN"
  plaintext_value = var.terraform_token
}

resource "github_actions_secret" "lil_linko_dockerhub_username" {
  repository      = "lil-linko"
  secret_name     = "DOCKERHUB_USERNAME"
  plaintext_value = var.dockerhub_username
}

resource "github_actions_secret" "lil_linko_dockerhub_token" {
  repository      = "lil-linko"
  secret_name     = "DOCKERHUB_TOKEN"
  plaintext_value = var.dockerhub_token
}

resource "github_actions_secret" "lil_linko_cloudflare_token" {
  repository      = "lil-linko"
  secret_name     = "CLOUDFLARE_API_TOKEN"
  plaintext_value = var.cloudflare_api_token
}

resource "github_actions_secret" "lil_linko_kubernetes_config_file" {
  repository      = "lil-linko"
  secret_name     = "KUBE_CONFIG"
  plaintext_value = var.kube_config
}

resource "github_actions_secret" "lil_linko_terraform_cloud_token" {
  repository      = "lil-linko"
  secret_name     = "TERRAFORM_TOKEN"
  plaintext_value = var.terraform_token
}

resource "github_actions_secret" "lil_linko_terraform_abstract_token" {
  repository      = "lil-linko"
  secret_name     = "ABSTRACT_TOKEN"
  plaintext_value = var.abstract_token
}

resource "github_actions_secret" "lil_linko_terraform_db_url_token" {
  repository      = "lil-linko"
  secret_name     = "LIL_LINKO_DB_URL"
  plaintext_value = var.lil_linko_db_url
}

resource "github_actions_secret" "my_ip_dockerhub_username" {
  repository      = "my-ip"
  secret_name     = "DOCKERHUB_USERNAME"
  plaintext_value = var.dockerhub_username
}

resource "github_actions_secret" "my_ip_dockerhub_token" {
  repository      = "my-ip"
  secret_name     = "DOCKERHUB_TOKEN"
  plaintext_value = var.dockerhub_token
}

resource "github_actions_secret" "my_ip_cloudflare_token" {
  repository      = "my-ip"
  secret_name     = "CLOUDFLARE_API_TOKEN"
  plaintext_value = var.cloudflare_api_token
}

resource "github_actions_secret" "my_ip_kubernetes_config_file" {
  repository      = "my-ip"
  secret_name     = "KUBE_CONFIG"
  plaintext_value = var.kube_config
}

resource "github_actions_secret" "my_ip_terraform_cloud_token" {
  repository      = "my-ip"
  secret_name     = "TERRAFORM_TOKEN"
  plaintext_value = var.terraform_token
}

resource "github_actions_secret" "my_ip_terraform_abstract_token" {
  repository      = "my-ip"
  secret_name     = "ABSTRACT_TOKEN"
  plaintext_value = var.abstract_token
}


resource "github_actions_secret" "celebrator_3000_dockerhub_username" {
  repository      = "celebrator-3000"
  secret_name     = "DOCKERHUB_USERNAME"
  plaintext_value = var.dockerhub_username
}

resource "github_actions_secret" "celebrator_3000_dockerhub_token" {
  repository      = "celebrator-3000"
  secret_name     = "DOCKERHUB_TOKEN"
  plaintext_value = var.dockerhub_token
}

resource "github_actions_secret" "celebrator_3000_cloudflare_token" {
  repository      = "celebrator-3000"
  secret_name     = "CLOUDFLARE_API_TOKEN"
  plaintext_value = var.cloudflare_api_token
}

resource "github_actions_secret" "celebrator_3000_kubernetes_config_file" {
  repository      = "celebrator-3000"
  secret_name     = "KUBE_CONFIG"
  plaintext_value = var.kube_config
}

resource "github_actions_secret" "celebrator_3000_terraform_cloud_token" {
  repository      = "celebrator-3000"
  secret_name     = "TERRAFORM_TOKEN"
  plaintext_value = var.terraform_token
}

resource "github_actions_secret" "celebrator_3000_terraform_basin_host" {
  repository      = "celebrator-3000"
  secret_name     = "CELEBRATOR_BASIN_HOST"
  plaintext_value = var.celebrator_basin_host
}

resource "github_actions_secret" "celebrator_3000_terraform_database_url" {
  repository      = "celebrator-3000"
  secret_name     = "CELEBRATOR_DATABASE_URL"
  plaintext_value = var.celebrator_database_url
}

resource "github_actions_secret" "celebrator_3000_terraform_rabbitmq_username" {
  repository      = "celebrator-3000"
  secret_name     = "CELEBRATOR_RABBITMQ_USERNAME"
  plaintext_value = var.celebrator_rabbitmq_username
}

resource "github_actions_secret" "celebrator_3000_terraform_rabbitmq_password" {
  repository      = "celebrator-3000"
  secret_name     = "CELEBRATOR_RABBITMQ_PASSWORD"
  plaintext_value = var.celebrator_rabbitmq_password
}

resource "github_actions_secret" "celebrator_3000_terraform_rabbitmq_host" {
  repository      = "celebrator-3000"
  secret_name     = "CELEBRATOR_RABBITMQ_HOST"
  plaintext_value = var.celebrator_rabbitmq_host
}

resource "github_actions_secret" "celebrator_3000_terraform_rabbitmq_port" {
  repository      = "celebrator-3000"
  secret_name     = "CELEBRATOR_RABBITMQ_PORT"
  plaintext_value = var.celebrator_rabbitmq_port
}

resource "github_actions_secret" "celebrator_3000_terraform_emails" {
  repository      = "celebrator-3000"
  secret_name     = "CELEBRATOR_EMAILS"
  plaintext_value = var.celebrator_emails
}

resource "github_actions_secret" "you_are_star_dockerhub_username" {
  repository      = "you-are-my-star"
  secret_name     = "DOCKERHUB_USERNAME"
  plaintext_value = var.dockerhub_username
}

resource "github_actions_secret" "you_are_star_dockerhub_token" {
  repository      = "you-are-my-star"
  secret_name     = "DOCKERHUB_TOKEN"
  plaintext_value = var.dockerhub_token
}

resource "github_actions_secret" "you_are_star_cloudflare_token" {
  repository      = "you-are-my-star"
  secret_name     = "CLOUDFLARE_API_TOKEN"
  plaintext_value = var.cloudflare_api_token
}

resource "github_actions_secret" "you_are_star_kubernetes_config_file" {
  repository      = "you-are-my-star"
  secret_name     = "KUBE_CONFIG"
  plaintext_value = var.kube_config
}

resource "github_actions_secret" "you_are_star_terraform_cloud_token" {
  repository      = "you-are-my-star"
  secret_name     = "TERRAFORM_TOKEN"
  plaintext_value = var.terraform_token
}

resource "github_actions_secret" "you_are_star_terraform_abstract_token" {
  repository      = "you-are-my-star"
  secret_name     = "STAR_GITHUB_TOKEN"
  plaintext_value = var.star_github_token
}



