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
  default = ["websecure"]
}