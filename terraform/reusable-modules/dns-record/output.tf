output "fqdn" {
  value = "${var.host_name}.${local.zone_name}"
}