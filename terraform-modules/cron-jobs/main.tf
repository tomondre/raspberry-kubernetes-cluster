terraform {
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["cron-jobs"]
    }
  }
}

module "celebrator-3000" {
  source    = "../reusable-modules/cron-job"
  cron      = "0 6 * * *"
  image_url = "docker.io/tomondre/celebrator-3000"
  name      = "celebrator-3000"
  image_tag = var.image_tag
  env       = var.env
}

variable "env" {}
variable "image_tag" {}
