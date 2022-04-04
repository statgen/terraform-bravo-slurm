variable "GOOGLE_CREDENTIALS" {
  description = "Placeholder to avoid warning from TF Cloud apply"
  type        = string
  default     = ""
}

variable "region" {
  description = "Single GCP region to allocate resources"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Single GCP zone to allocate resources"
  type        = string
  default     = "us-central1-c"
}

variable "project" {
  description = "GCP project name"
  default = null
}

# Placeholders for vars of modules passed verbatim
#   See io.tf of modules for full description.
variable "controller_machine_type" {}
variable "controller_image"        {}
variable "controller_disk_type"    {}
variable "controller_disk_size_gb" {}

variable "cluster_name" {}
variable "partitions" {}
variable "controller_labels" {}
