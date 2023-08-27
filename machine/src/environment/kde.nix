{ pkgs, ... }:
{
  services.xserver.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";
  services.xserver.desktopManager.plasma5.enable = true;

  # services.xserver.desktopManager.plasma5.bigscreen.enable = true;

  environment.systemPackages = with pkgs; [
    # rar support for kde dolphin/ark
    rar
    unrar

    # better screenshots
    flameshot
  ];

  programs.kdeconnect.enable = true;
}

