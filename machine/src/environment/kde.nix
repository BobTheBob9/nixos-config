{ pkgs, ... }:
    let pkgs_waylandFlameshot = import (pkgs.fetchFromGitHub {
        owner = "haizaar";
        repo = "nixpkgs";
        rev = "ca6081cbce02589ad9594350ce6e5bca39b09ad1";
        sha256 = "6lOu2O4KAYfGccHdZQUEr2A3mdwEtcr3S7pyLxxlZII=";
    }) {};
in
{
    services.xserver.enable = true;

    # Enable the KDE Desktop Environment.
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.displayManager.defaultSession = "plasmawayland";
    services.xserver.desktopManager.plasma5.enable = true;

    # services.xserver.desktopManager.plasma5.bigscreen.enable = true;

    environment.systemPackages = with pkgs; [
        # mount stuff like networked storage as a filesystem driver
        kio-fuse

        # rar support for kde dolphin/ark
        rar
        unrar

        # better screenshots
        pkgs_waylandFlameshot.flameshot
        xdg-desktop-portal
        xdg-desktop-portal-kde
    ];

    programs.kdeconnect.enable = true;
}

