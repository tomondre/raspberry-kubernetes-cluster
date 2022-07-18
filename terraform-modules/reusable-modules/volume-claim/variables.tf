variable "app_name" {
  type = string
}

variable "storage" {
  type = string
}

variable "access_modes" {
  type = list(string)
  default = ["ReadWriteOnce"]
}

variable "volume_name" {
  type = string
  description = "The default volume needs to be already created"
  default = "hdd-test-volume"
}

variable "storage_class" {
  type = string
  default = "local-path"
}