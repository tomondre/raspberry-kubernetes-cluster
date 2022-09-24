variable "name" {
  type = string
}

variable "namespace" {
  type = string
  default = "default"
}

variable "data" {
  type = map(string)
}

variable "type" {
  type = string
  default = "Opaque"
}