variable "env" {
  type    = map(string)
  default = {}
}

variable "cron" {
  type = string
}

variable "image_url" {
  type = string
}

variable "name" {
  type = string
}

variable "image_tag" {
  type = string
}