# Unlike hardware-configuration.nix which is automatically generated, this is not!
# This file is for custom hardware stuff that (unfortunately) couldn't be automatically generated
# e.g. ntfs mounting, because the nixos automatic generator can't figure that out rn it seems

{
  fileSystems."/mnt/funny-largentfs".options = [ "x-gvfs-show" ];
  fileSystems."/mnt/fastgames".options = [ "x-gvfs-show" ];
}

