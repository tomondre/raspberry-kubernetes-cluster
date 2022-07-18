variable "kubernetes_config_file_path" {
  type = string
}

variable "transport_name" {
  type    = string
  default = "insecure-skip-transport"
}

variable "transport_namespace" {
  type = string
}