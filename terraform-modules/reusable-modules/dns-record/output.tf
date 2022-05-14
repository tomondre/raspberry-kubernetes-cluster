output "fqdn" {
  value = "${var.service_name}.${local.zone_name}"
}