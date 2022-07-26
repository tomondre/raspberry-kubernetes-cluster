locals {
  app            = "cloud"
}

#module "record" {
#  source = "../reusable-modules/dns-record"
#  host_name = local.app
#}
#
#module "ssh_record" {
#  source = "../reusable-modules/dns-record"
#  host_name = "ssh"
#}