variable "name" {
  type = string
}

variable "namespace" {
  type = string
  default = "default"
}

variable "whitelist_ips" {
  type = string
  description = "It is important to follow yaml whitespaces and create single line implementation of this variable!"
}