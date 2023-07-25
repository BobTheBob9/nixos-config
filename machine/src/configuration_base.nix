{ config, pkgs, ... }:
{
  imports = [ 
    # Include the results of the hardware scan.
    # TODO: this should probably be part of the makefile
    ./hardware-configuration.nix
    ./hardware-configuration-custom.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.supportedFilesystems = [ "ntfs" ];
  #boot.kernelModules = [ "v4l2loopback" ];
  #boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bobthebob = {
    isNormalUser = true;
    description = "bobthebob";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "bobthebob";

  # nur
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    git
    neofetch
    home-manager
    man-pages
    #linuxPackages.v4l2loopback # uncertain if still needed here..?
    #v4l-utils
  ];

  programs.steam = { 
    enable = true; 
    remotePlay.openFirewall = true;
    #localNetworkGameTransfers.openFirewall = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
