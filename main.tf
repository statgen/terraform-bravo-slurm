provider "google" {
  project = var.project
  region  = local.region
  zone    = var.zone
}

locals {
  region = join("-", slice(split("-", var.zone), 0, 2))

  network_storage = [{
    server_ip     = data.tfe_outputs.slurm_network.values.filestore_ip_home
    remote_mount  = data.tfe_outputs.slurm_network.values.filestore_name_home
    local_mount   = "/home"
    fs_type       = "nfs"
    #mount_options = "hard,timeo=600,retrans=3,rsize=1048576,wsize=1048576,resvport,async"
    mount_options = null

  },{
    server_ip     = data.tfe_outputs.slurm_network.values.filestore_ip_app
    remote_mount  = data.tfe_outputs.slurm_network.values.filestore_name_app
    local_mount   = "/apps"
    fs_type       = "nfs"
    mount_options = "hard,timeo=600,retrans=3,rsize=1048576,wsize=1048576,resvport,async"
  }]

  partitions = [
    { name                 = "debug"
      machine_type         = "c2-standard-4"
      static_node_count    = 3
      max_node_count       = 3
      zone                 = var.zone
      image                = "projects/schedmd-slurm-public/global/images/family/schedmd-slurm-21-08-6-debian-10"
      image_hyperthreads   = true
      compute_disk_type    = "pd-standard"
      compute_disk_size_gb = 20
      compute_labels       = {}
      cpu_platform         = null
      gpu_count            = 0
      gpu_type             = null
      network_storage      = []
      preemptible_bursting = false
      vpc_subnet           = data.google_compute_subnetwork.slurm_subnet.self_link
      exclusive            = false
      enable_placement     = false
      regional_capacity    = false
      regional_policy      = {}
      instance_template    = null
    }
  ]
}

#############################################################
# Get network & storage from supporting terraform workspace #
#############################################################

# To lookup filestore_ip, network_name, subnet_name
data "tfe_outputs" "slurm_network" {
  organization = "statgen"
  workspace = "bravo-slurm-network"
}

data "google_compute_subnetwork" "slurm_network" {
  name = data.tfe_outputs.slurm_network.values.network_name
}

data "google_compute_subnetwork" "slurm_subnet" {
  name = data.tfe_outputs.slurm_network.values.subnet_name
}


#######################################################
# Provision slurm infrastructure within given network #
#######################################################

module "common" {
  source = "./modules/common"
}

###########
# Network #
###########

# Network and storage provided by supporting terraform workspace

##############################
# Controller, Login, Compute #
##############################
module "slurm_cluster_controller" {
  source = "./modules/controller"

  boot_disk_size                = var.controller_disk_size_gb
  boot_disk_type                = var.controller_disk_type
  image                         = var.controller_image
  # instance_template             = var.controller_instance_template
  cluster_name                  = var.cluster_name

  network_storage = local.network_storage

  partitions                    = local.partitions
  project                       = var.project
  region                        = local.region

  # compute_node_scopes           = var.compute_node_scopes
  # compute_node_service_account  = var.compute_node_service_account
  # disable_compute_public_ips    = var.disable_compute_public_ips
  # disable_controller_public_ips = var.disable_controller_public_ips
  labels                          = var.controller_labels

  # login_network_storage         = var.login_network_storage
  # login_node_count              = var.login_node_count
  # machine_type                  = var.controller_machine_type
  # munge_key                     = var.munge_key
  # jwt_key                       = var.jwt_key
  # secondary_disk                = var.controller_secondary_disk
  # secondary_disk_size           = var.controller_secondary_disk_size
  # secondary_disk_type           = var.controller_secondary_disk_type
  # shared_vpc_host_project       = var.shared_vpc_host_project
  scopes                          = ["cloud-platform", "monitoring-write","logging-write","storage-rw"]
  # service_account               = var.controller_service_account

  subnet_depend                 = data.google_compute_subnetwork.slurm_subnet.self_link
  subnetwork_name               = data.google_compute_subnetwork.slurm_subnet.self_link

  # suspend_time                  = var.suspend_time
  # complete_wait_time            = var.complete_wait_time

  zone                          = var.zone
  # intel_select_solution         = var.intel_select_solution

  ## Required Runtime Scripts
  ##   Provided by 'common' module instead of external file refs.
  controller_startup_script = module.common.custom_controller_install
  compute_startup_script    = module.common.custom_compute_install
  metadata_startup_script   = module.common.metadata_startup_script
  cgroup_conf_tpl           = module.common.cgroup_conf_tpl
  setup_script              = module.common.setup_script
  slurm_resume              = module.common.slurm_resume
  slurm_suspend             = module.common.slurm_suspend
  slurm_conf_tpl            = module.common.slurm_conf_tpl
  slurmdbd_conf_tpl         = module.common.slurmdbd_conf_tpl
  slurmsync                 = module.common.slurmsync
  util_script               = module.common.util_script
}

module "slurm_cluster_login" {
  source = "./modules/login"

  # boot_disk_size            = var.login_disk_size_gb
  # boot_disk_type            = var.login_disk_type
  image                     = var.login_image
  # instance_template         = var.login_instance_template
  cluster_name              = var.cluster_name
  controller_name           = module.slurm_cluster_controller.controller_node_name
  # controller_secondary_disk = var.controller_secondary_disk
  # disable_login_public_ips  = var.disable_login_public_ips
  labels                    = var.login_labels
  # login_network_storage     = var.login_network_storage
  # machine_type              = var.login_machine_type
  node_count                = var.login_node_count
  region                    = local.region
  # scopes                    = var.login_node_scopes
  scopes                      = ["cloud-platform", "monitoring-write","logging-write","storage-rw"]
  # service_account           = var.login_node_service_account
  # munge_key                 = var.munge_key
  network_storage           = local.network_storage

  subnet_depend                 = data.google_compute_subnetwork.slurm_subnet.self_link
  subnetwork_name               = data.google_compute_subnetwork.slurm_subnet.self_link
  zone                      = var.zone

  ## Required Runtime Scripts
  ##   Provided by 'common' module instead of external file refs.
  login_startup_script      = module.common.custom_compute_install
  metadata_startup_script   = module.common.metadata_startup_script
  util_script = module.common.util_script
  setup_script = module.common.setup_script
}

module "slurm_cluster_compute" {
  source = "./modules/compute"

  cluster_name               = var.cluster_name
  controller_name            = module.slurm_cluster_controller.controller_node_name
  network_storage            = local.network_storage
  partitions                 = local.partitions
  project                    = var.project
  region                     = local.region
  scopes                      = ["monitoring-write","logging-write","storage-rw"]

  subnet_depend              = data.google_compute_subnetwork.slurm_subnet.self_link
  subnetwork_name            = data.google_compute_subnetwork.slurm_subnet.self_link
  zone                       = var.zone

  ## Required Runtime Scripts
  ##   Provided by 'common' module instead of external file refs.
  compute_startup_script     = module.common.custom_compute_install
  metadata_startup_script    = module.common.metadata_startup_script
  util_script                = module.common.util_script
  setup_script               = module.common.setup_script
}
