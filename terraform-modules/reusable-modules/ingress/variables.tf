variable "service_name" {
  type = string
}

variable "service_port" {
  type = string
}

variable "service_namespace" {
  type = string
}

variable "ingress_host_fqdn" {
  type = string
}

variable "entrypoint" {
  type = string
  default = "web"
}