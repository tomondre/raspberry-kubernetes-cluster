variable "cloudflare_email" {
  type = string
}

variable "cloudflare_api_token" {
  type = string
}

variable "lil_linko_abstract_api_key" {
  type        = string
  description = "Lil Linko Abstract API Key"
}

variable "lil_linko_db_url" {
  type        = string
  description = "Lil Linko DB URL. The format is: databaseType://user:password@host:port/database"
}

variable "api_tomondre_db_url" {
  type        = string
  description = "API Tomondre DB URL. The format is: databaseType://user:password@host:port/database"
}