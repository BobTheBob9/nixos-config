# creates the Worst Formatted nix configuration file of All Time
# this should be run from this repo's makefile, not run manually!!!

echo -e "# automatically generated nixos configuration
{ config, pkgs, ... }:
{
\timports = [
\t\t./configuration_base.nix" > configuration.nix

if [ "$GPU_NVIDIA" == "1" ] 
then
    echo -e "\t\t./sys/nvidia.nix" >> configuration.nix
fi

if [ "$GPU_AMD" == "1" ] 
then
    echo -e "\t\t./sys/amd.nix" >> configuration.nix
fi

if [ "$SOUND_PIPEWIRE" == "1" ]
then
    echo -e "\t\t./sys/pipewire.nix" >> configuration.nix
fi

if [ "$NETWORKING" == "1" ]
then
    echo -e "\t\t./sys/network.nix" >> configuration.nix
fi

if [ "$SSH_SERVER" == "1" ]
then
    echo -e "\t\t./sys/ssh_server.nix" >> configuration.nix
fi

if [ "$SMB_SERVER" == "1" ]
then
    echo -e "\t\t./sys/samba.nix" >> configuration.nix
fi

if [ "$LOCALE_ENGLAND" == "1" ]
then
    echo -e "\t\t./sys/locale_england.nix" >> configuration.nix
fi

if [ "$ENVIRONMENT_KDE" == "1" ]
then
    echo -e "\t\t./environment/kde.nix" >> configuration.nix
fi

if [ "$ENVIRONMENT_GNOME" == "1" ]
then
    echo -e "\t\t./environment/gnome.nix" >> configuration.nix
fi

echo -e "\t];
}" >> configuration.nix
