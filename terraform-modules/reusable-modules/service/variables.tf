variable "service_name" {
  type = string
}

variable "service_port" {
  type = number
  default = 8080
}

variable "container_port" {
  type = number
}

variable "namespace" {
  type = string
}