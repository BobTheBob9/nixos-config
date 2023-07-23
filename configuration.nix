{ config, pkgs, ... }:
{
	imports = [
		./configuration_base.nix
		./sys/nvidia.nix
		./sys/pipewire.nix
		./sys/networking.nix
		./sys/locale_england.nix
		./environment/kde.nix
	];
}
