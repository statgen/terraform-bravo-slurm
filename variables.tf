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
  type        = string
}

variable "results_bucket" {
  description = "GCP bucket to store pipline outputs"
  type        = string
}

variable "input_vcfs_bucket" {
  description = "GCP requestor pays bucket with source VCF files."
  type        = string
}

variable "crams_1000g_bucket" {
  description = "GCP requestor pays bucket with source CRAM files for 1000 genomes samples."
  type        = string
}

variable "crams_topmed_bucket" {
  description = "GCP requestor pays bucket with source CRAM files from TOPMED."
  type        = string
}

variable "crams_ccdg_bucket" {
  description = "GCP requestor pays bucket with source CRAM files from CCDG."
  type        = string
}

variable "crams_ccdg_tmp_bucket" {
  description = "GCP requestor pays bucket with source CRAM files from CCDG."
  type        = string
}

# Placeholders for vars of modules passed verbatim
#   See io.tf of modules for full description.
variable "cluster_name" {}

variable "controller_machine_type" {}
variable "controller_image"        {
  description = "VM image for controller machine"
  type = string
  default = "projects/schedmd-slurm-public/global/images/family/schedmd-slurm-21-08-6-debian-10"
}
variable "controller_disk_type"    {}
variable "controller_disk_size_gb" {}
variable "controller_labels"       {}

variable "login_machine_type" {}
variable "login_node_count"   {}
variable "login_image"        {
  description = "VM image for login machine"
  type = string
  default = "projects/schedmd-slurm-public/global/images/family/schedmd-slurm-21-08-6-debian-10"
}
variable "login_disk_type"    {}
variable "login_disk_size_gb" {}
variable "login_labels"       {}
