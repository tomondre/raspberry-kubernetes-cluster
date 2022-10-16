variable "namespace" {
  type    = string
  default = "default"
}

variable "labels" {
  type = string
  default = null
}

variable "service_name" {
  type    = string
}

variable "replicas" {
  type    = number
  default = 1
}

variable "image_url" {
  type = string
}

variable "command" {
  default = []
}

variable "image_tag" {
  type = string
}

variable "cpu_limit" {
  type    = string
  default = "0.5"
}

variable "memory_limit" {
  type    = string
  default = "512Mi"
}

variable "cpu_request" {
  type    = string
  default = "250m"
}

variable "memory_request" {
  type    = string
  default = "50Mi"
}

variable "health_check_path" {
  type = string
  default = ""
}

variable "args" {
  type = list(string)
  default = []
}

variable "port" {
  type    = number
  default = 80
}

variable "env" {
  type = map(string)
  default = {}
}

variable "port_name" {
  type = string
  default = null
}

variable "additional_port" {
  type = list(map(string))
  default = []
}