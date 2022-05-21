variable "cloudflare_email" {
  type = string
}

variable "cloudflare_api_token" {
  type = string
}

variable "server_ip" {
  type = string
}

variable "whitelist_ips" {
  type = string
  description = "It is important to follow yaml whitespaces and create single line implementation of this variable!"
}