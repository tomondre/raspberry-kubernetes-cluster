locals {
  lil_linko_host = "url"
}

module "api_cv_deployment" {
  source            = "../reusable-modules/deployment"
  name              = "api-cv"
  health_check_path = "/"
  image_tag         = "5"
  image_url         = "docker.io/tomondre/api-cv"
  port              = 9000
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
}

module "portfolio_deployment" {
  source            = "../reusable-modules/deployment"
  name              = "portfolio"
  health_check_path = "/Healthcheck.html"
  image_tag         = "4"
  image_url         = "docker.io/tomondre/portfolio"
  port              = 80
}

module "lil_linko_deployment" {
  source            = "../reusable-modules/deployment"
  health_check_path = "/healthcheck"
  image_tag         = "17"
  image_url         = "docker.io/tomondre/lil-linko"
  name              = local.lil_linko_host
  port              = 8080
  env               = {
    DATABASE_URL     = var.lil_linko_db_url
    HOST_URL         = "https://${local.lil_linko_host}.tomondre.com"
    ABSTRACT_API_KEY = var.lil_linko_abstract_api_key
  }
}

module "deployments_overview_page" {
  source            = "../reusable-modules/deployment"
  health_check_path = "/"
  image_tag         = "7"
  image_url         = "docker.io/tomondre/deployments-page"
  name              = "deployments"
  port              = 80
}

#Change the internal dns call that ends with .tomondre.com to be routed to the load balancer of the kubernetes cluster
module "is_ok_deployment" {
  source            = "../reusable-modules/deployment"
  health_check_path = "/health"
  image_tag         = "4"
  image_url         = "docker.io/tomondre/is-ok"
  name              = "is-ok"
  port              = 8080
}

#For DEBUG purposes
#For some weird reason, the deployment is clashing with other services using the same port - 80. I have to investigate a bit more what is this problem
#module "request_echo_deployment" {
#  source            = "../reusable-modules/deployment"
#  health_check_path = "/"
#  image_tag         = "23"
#  image_url         = "docker.io/mendhak/http-https-echo"
#  name              = "request-echo"
#  port              = 80
#}
