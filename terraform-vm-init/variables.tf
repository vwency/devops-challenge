variable "libvirt_uri" {
  type    = string
  default = "qemu:///system"
}

variable "storage_pool" {
  type    = string
  default = "default"
}

variable "network_name" {
  type    = string
  default = "default"
}

variable "base_image_url" {
  type    = string
  default = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

variable "master_memory" {
  type    = string
  default = "9065"
}

variable "master_vcpu" {
  type    = number
  default = 6
}

variable "master_disk_size" {
  type    = number
  default = 35687091200
}

variable "worker_count" {
  type    = number
  default = 6
}

variable "worker_memory" {
  type    = string
  default = "2048"
}

variable "worker_vcpu" {
  type    = number
  default = 2
}

variable "worker_disk_size" {
  type    = number
  default = 11474836480
}
