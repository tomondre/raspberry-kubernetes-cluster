variable "repo_owner" {
  type = string
  default = "tomondre"
}

variable "repo_name" {
  type = string
}

variable "replicas" {
  type = number
  default = 1
}

variable "namespace" {
  type = string
  default = "actions-runner-system"
}