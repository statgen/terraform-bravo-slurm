# Configuration provided in terraform cloud workspace
# cluster_name = "example-name"
# project      = "example-project"
# zone         = "us-central1-c"
# 
# login_labels = {
#   terraform = "true"
#   project = "example-project"
# }
# 
# controller_labels = {
#   terraform = "true"
#   project = "example-project"
# }


# Generic configuration

controller_machine_type = "n1-standard-2"
controller_image        = "projects/schedmd-slurm-public/global/images/family/schedmd-slurm-21-08-6-hpc-centos-7"
controller_disk_type    = "pd-standard"
controller_disk_size_gb = 20

login_machine_type = "n1-standard-2"
login_image        = "projects/schedmd-slurm-public/global/images/family/schedmd-slurm-21-08-6-hpc-centos-7"
login_disk_type    = "pd-standard"
login_disk_size_gb = 20

partitions = [
  { name                 = "debug"
    machine_type         = "c2-standard-4"
    static_node_count    = 0
    max_node_count       = 10
    zone                 = "us-central1-a"
    image                = "projects/schedmd-slurm-public/global/images/family/schedmd-slurm-21-08-6-hpc-centos-7"
    image_hyperthreads   = true
    compute_disk_type    = "pd-standard"
    compute_disk_size_gb = 20
    compute_labels       = {}
    cpu_platform         = null
    gpu_count            = 0
    gpu_type             = null
    network_storage      = []
    preemptible_bursting = false
    vpc_subnet           = null
    exclusive            = false
    enable_placement     = false
    regional_capacity    = false
    regional_policy      = {}
    instance_template    = null
  }
]
