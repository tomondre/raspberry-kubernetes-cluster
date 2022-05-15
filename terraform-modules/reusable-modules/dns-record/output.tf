output "fqdn" {
  value = "${var.record_host}.${local.zone_name}"
}