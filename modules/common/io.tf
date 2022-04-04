output "cgroup_conf_tpl" {
 value = data.local_file.cgroup_conf_tpl.content
}

output "custom_compute_install" {
 value = data.local_file.custom_compute_install.content
}

output "custom_controller_install" {
 value = data.local_file.custom_controller_install.content
}

output "metadata_startup_script" {
 value = data.local_file.metadata_startup_script.content
}

output "setup_script" {
 value = data.local_file.setup_script.content
}

output "slurm_resume" {
 value = data.local_file.slurm_resume.content
}

output "slurm_suspend" {
 value = data.local_file.slurm_suspend.content
}

output "slurm_conf_tpl" {
 value = data.local_file.slurm_conf_tpl.content
}

output "slurmdbd_conf_tpl" {
 value = data.local_file.slurmdbd_conf_tpl.content
}

output "slurmsync" {
 value = data.local_file.slurmsync.content
}

output "util_script" {
 value = data.local_file.util_script.content
}
