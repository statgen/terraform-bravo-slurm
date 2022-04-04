# Slurm Scripts Commons
This module is a workaround for the need of the startup scripts to be provided to the slurm submodules as strings.

## Reason
The original implementation had the modules reading files outside of their file structure.
That would not work for terraform cloud uses of those modules.
That would also not work if the module was moved around in a project or the supporting files were moved.
In short, the original implementation was brittle.

## Work Around
This module allows others to call it's outputs and get the contents of the scripts as string.
Alleviates other modules having to have their own copies.
Alleviates other modules having to reference paths outside their directory tree.

## Source of files
- https://github.com/SchedMD/slurm-gcp/tree/master/scripts
- https://github.com/SchedMD/slurm-gcp/tree/master/etc
