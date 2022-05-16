terraform {
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["deployments"]
    }
  }
}

module "api_cv_deployment" {
  source            = "../reusable-modules/deployment"
  name              = "api-cv"
  health_check_path = "/"
  image_tag         = "5"
  image_url         = "docker.io/tomondre/api-cv"
  port              = 9000
  server_ip         = var.server_ip
  entrypoint = ["web", "websecure"]
  env               = {
    HOST = "api-cv.tomondre.com"
  }
}

module "lego_scraper_deployment" {
  source            = "../reusable-modules/deployment"
  name              = "lego-scraper"
  health_check_path = "/"
  image_tag         = "1"
  image_url         = "docker.io/tomondre/lego-scraper"
  port              = 9000
  server_ip         = var.server_ip
}

module "portfolio_deployment" {
  source            = "../reusable-modules/deployment"
  name              = "portfolio"
  health_check_path = "/Healthcheck.html"
  image_tag         = "4"
  image_url         = "docker.io/tomondre/portfolio"
  port              = 80
  server_ip         = var.server_ip
}