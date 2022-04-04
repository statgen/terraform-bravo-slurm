data "local_file" "cgroup_conf_tpl" {
 filename = "${path.module}/etc/cgroup.conf.tpl"
}

data "local_file" "custom_compute_install" {
 filename = "${path.module}/scripts/custom-compute-install"
}

data "local_file" "custom_controller_install" {
 filename = "${path.module}/scripts/custom-controller-install"
}

data "local_file" "metadata_startup_script" {
 filename = "${path.module}/scripts/startup.sh"
}

data "local_file" "setup_script" {
 filename = "${path.module}/scripts/setup.py"
}

data "local_file" "slurm_resume" {
 filename = "${path.module}/scripts/resume.py"
}

data "local_file" "slurm_suspend" {
 filename = "${path.module}/scripts/suspend.py"
}

data "local_file" "slurm_conf_tpl" {
 filename = "${path.module}/etc/slurm.conf.tpl"
}

data "local_file" "slurmdbd_conf_tpl" {
 filename = "${path.module}/etc/slurmdbd.conf.tpl"
}

data "local_file" "slurmsync" {
 filename = "${path.module}/scripts/slurmsync.py"
}

data "local_file" "util_script" {
 filename = "${path.module}/scripts/util.py"
}

### Examples of previous use:
# modules/compute/main.tf:  metadata_startup_script = file("${path.module}/../../../scripts/startup.sh")
# modules/login/main.tf:    setup-script = file("${path.module}/../../../scripts/setup.py")
# modules/controller/main.tf:    slurm-resume              = file("${path.module}/../../../scripts/resume.py")
