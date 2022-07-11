## GCP Data Pipeline Compute Infrastructure
Compute instances for SLURM cluster to run BRAVO Data Prep

## TODO
Try to use debian image instead of centos7:
```
projects/schedmd-slurm-public/global/images/family/schedmd-slurm-21-08-6-debian-10 
```

## Notes
- A GCP bucket for results needs to be extant prior to provisioning VMs

To have OS Login manage ancillary groups for OS Login users requires Cloud Identity Groups.
However, these groups are managed at the organization level.
- Cloud Identity Groups API must be enabled for project
- POSIX Group for slurm users must be created via Cloud Identity Group API
- This is unavaiable at the project level.
Need to find a different solution to mapping OS Login users to a group on all nodes.
