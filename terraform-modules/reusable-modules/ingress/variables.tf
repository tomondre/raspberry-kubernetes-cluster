variable "service_name" {
  type = string
}

variable "service_port" {
  type = string
}

variable "service_namespace" {
  type = string
}

variable "host_name" {
  type = string
}

variable "entrypoint" {
  type = list(string)
  default = ["websecure", "web"]
}

variable "cert_name" {
  type = string
  description = "The cert needs to be already generated so that this name can be set."
  default = "wildcard-cert"
}

variable "server_transport" {
  type = string
  default = "insecure-skip-transport"
  description = "This transport needs to be created beforehand"
}

variable "scheme" {
  type = string
}

#variable "insecure_skip_verify" {
#  type = bool
#  default = false
#}