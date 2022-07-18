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

#For DEBUG purposes
#module "request_echo_deployment" {
#  source = "../reusable-modules/deployment"
#  health_check_path = "/"
#  image_tag = "23"
#  image_url = "docker.io/mendhak/http-https-echo"
#  name = "request-echo"
#  port = 8080
#}
