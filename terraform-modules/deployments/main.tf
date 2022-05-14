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
  image_tag         = "3"
  image_url         = "docker.io/tomondre/api-cv"
  port              = 9000
  server_ip         = var.server_ip
  env = {
    HOST = "api-cv.tomondre.com"
  }
}