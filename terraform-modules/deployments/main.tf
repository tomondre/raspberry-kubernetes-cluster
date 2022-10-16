locals {
  lil_linko_host = "url"
}

module "api_cv_deployment" {
  source            = "../reusable-modules/full-deployment"
  service_name      = "api-cv"
  health_check_path = "/"
  image_tag         = "7"
  image_url         = "docker.io/tomondre/api-cv"
  port              = 9000
  env               = {
    PORT                         = 9000
    HOST                         = "https://api-cv.tomondre.com/"
    API_URL                      = "https://api.tomondre.com/"
    NODE_TLS_REJECT_UNAUTHORIZED = "0"
  }
}

module "lego_scraper_deployment" {
  source            = "../reusable-modules/full-deployment"
  service_name      = "lego-scraper"
  health_check_path = "/"
  image_tag         = "1"
  image_url         = "docker.io/tomondre/lego-scraper"
  port              = 9000
}

module "lil_linko_deployment" {
  source            = "../reusable-modules/full-deployment"
  health_check_path = "/healthcheck"
  image_tag         = "17"
  image_url         = "docker.io/tomondre/lil-linko"
  service_name      = local.lil_linko_host
  port              = 8080
  env               = {
    DATABASE_URL     = var.lil_linko_db_url
    HOST_URL         = "https://${local.lil_linko_host}.tomondre.com"
    ABSTRACT_API_KEY = var.lil_linko_abstract_api_key
  }
}

module "deployments_overview_page" {
  source            = "../reusable-modules/full-deployment"
  health_check_path = "/"
  image_tag         = "13"
  image_url         = "docker.io/tomondre/deployments-page"
  service_name      = "deployments"
  port              = 80
}

#Change the internal dns call that ends with .tomondre.com to be routed to the load balancer of the kubernetes cluster
module "is_ok_deployment" {
  source            = "../reusable-modules/full-deployment"
  health_check_path = "/health"
  image_tag         = "6"
  image_url         = "docker.io/tomondre/is-ok"
  service_name      = "is-ok"
  port              = 8080
}

module "api_tomondre_deployment" {
  source            = "../reusable-modules/full-deployment"
  health_check_path = "/healthCheck"
  image_tag         = "10"
  image_url         = "docker.io/tomondre/api-tomondre"
  service_name      = "api-tomondre"
  host_name         = "api"
  port              = 8080
  env               = {
    DATABASE_URL = var.api_tomondre_db_url
  }
}

#module "portfolio_deployment" {
#  source            = "../reusable-modules/full-deployment"
#  service_name      = "portfolio"
#  health_check_path = "/Healthcheck.html"
#  image_tag         = "4"
#  image_url         = "docker.io/tomondre/portfolio"
#  port              = 80
#}

module "portfolio_angular_deployment" {
  source            = "../reusable-modules/full-deployment"
  health_check_path = "/"
  image_tag         = "13"
  image_url         = "tomondre/portfolio-angular"
  service_name      = "portfolio"
  port              = 80
}

module "my_ip_api" {
  source            = "../reusable-modules/full-deployment"
  health_check_path = "/health"
  image_tag         = "4"
  image_url         = "tomondre/my-ip-api"
  service_name      = "my-ip-api"
  port              = 8080
  env               = {
    ABSTRACT_API_KEY = var.lil_linko_abstract_api_key
    PORT             = 8080
  }
}

module "my_ip" {
  source            = "../reusable-modules/full-deployment"
  health_check_path = "/Health.html"
  image_tag         = "5"
  image_url         = "tomondre/my-ip"
  service_name      = "my-ip"
  port              = 80
}

module "rabatoo_frontend" {
  source            = "../reusable-modules/full-deployment"
  service_name      = "rabatoo-frontend"
  host_name         = "rabatoo"
  health_check_path = "/"
  image_tag         = "3"
  image_url         = "docker.io/tomondre/rabatoo-frontend"
  port              = 80
  env               = {
    HOST = "https://rabatoo-api.tomondre.com"
  }
}

module "rabatoo_api" {
  source            = "../reusable-modules/full-deployment"
  service_name      = "rabatoo-api"
  health_check_path = "/health"
  image_tag         = "4"
  image_url         = "docker.io/tomondre/rabatoo-business-logic"
  port              = 80
  env               = {
    GRPC_SERVER = "http://rabatoo-grpc.default.svc.cluster.local:8080"
  }
}

module "rabatoo_grpc" {
  source            = "../reusable-modules/full-deployment"
  service_name      = "rabatoo-grpc"
  health_check_path = ""
  image_tag         = "5"
  image_url         = "docker.io/tomondre/rabatoo-grpc"
  port              = 9090
  cpu_limit         = "1000m"
  annotations       = { "traefik.ingress.kubernetes.io/service.serversscheme" = "h2c" }
  scheme            = "h2c"
}
