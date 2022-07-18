variable "email" {
  type = string
}

variable "cloudflare_api_token" {
  type = string
  default = "To generate this token, refer to: https://cert-manager.io/docs/configuration/acme/dns01/cloudflare/"
}
