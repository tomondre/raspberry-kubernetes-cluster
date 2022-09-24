variable "env" {
  type    = map(string)
  default = {}
}

variable "cron" {
  type = string
}

variable "image" {
  type = string
}

variable "name" {
  type = string
}

variable "tag" {
  type = string
}