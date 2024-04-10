{ config, pkgs, pkgs-unstable, pkgs-waylandFlameshot, nix-gaming, ... }:
{
    imports = [
        # Include the results of the hardware scan.
        # TODO: this should probably be part of the makefile
        ./hardware-configuration.nix
        ./hardware-configuration-custom.nix

        ./sys/locale_england.nix
        ./sys/nvidia.nix
        ./sys/network.nix
        ./sys/pipewire.nix
    ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.auto-optimise-store = true;
    nix.settings.substituters = ["https://nix-gaming.cachix.org"];
    nix.settings.trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";
    #boot.initrd.systemd.enable = true;
    #boot.plymouth.enable = true;
    #boot.plymouth.theme="breeze";

    # Enable windowing system.
    services.xserver.enable = true;

    # Enable the KDE Desktop Environment.
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.displayManager.defaultSession = "plasmawayland";
    services.xserver.desktopManager.plasma5.enable = true;
    programs.kdeconnect.enable = true;

    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.bobthebob = {
        isNormalUser = true;
        description = "bobthebob";
        extraGroups = [ "networkmanager" "wheel" ];
    };
    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = "bobthebob";

    environment.systemPackages = with pkgs; [
        # kde stuff
        # mount stuff like networked storage as a filesystem driver
        # TODO: kind of sucks, gnome's functionality for this is about 100x better but don't like using gnome
        # honestly, when i move off kde i'll probably just have something commandline to mount these
        kio-fuse
        plasma5Packages.kio-extras

        # rar support for kde dolphin/ark
        rar
        unrar

        # better screenshots
        pkgs-waylandFlameshot.flameshot
        xdg-desktop-portal
        xdg-desktop-portal-kde
	wl-clipboard

        #neovim
        wget
        git
        neofetch
        man-pages
        steam-run # fhs environment, useful for running unpackaged binaries

        discord
        konversation

        # tools
        obs-studio
        qbittorrent
        kate
        vlc
        aseprite
        krita

        # games
        #pkgs.osu-lazer-bin
        pkgs-unstable.prismlauncher
        pkgs-unstable.ironwail
        #inputs.ssbm.packages.x86_64-linux.slippi-launcher
        #inputs.aagl.packages.x86_64-linux.anime-game-launcher

        # games - emulators
        dolphin-emu
        yuzu-early-access
        snes9x-gtk
        citra
        desmume
        cemu

        # games - utilities
        protonup-ng # TODO: should declaratively manage
        #wineWowPackages.unstableFull
        nix-gaming.packages.${pkgs.hostPlatform.system}.wine-ge
        #pkgs.gamescope

        yakuake
        btop

	# we wrap kitty to specify env vars rather than doing it with environment.sessionVars because the latter requires a relog to reset after rebuilding, whereas this will update as soon as we rebuild our config
	(pkgs.symlinkJoin {
	    name = "kitty";
	    paths = [ pkgs.kitty ];
	    nativeBuildInputs = [ pkgs.makeWrapper ];
	    postBuild = ''
		wrapProgram $out/bin/kitty \
		    --set KITTY_CONFIG_DIRECTORY "${./ext/kitty}"
		'';
	})
    	(neovim.override {
            configure = {
                packages.plugins = with pkgs.vimPlugins; {
        	     start = [ barbar-nvim ];
	        };
	    };
        })
	(pkgs.writeShellScriptBin "dev" ( builtins.readFile ./ext/dev.sh ))
    ];

    programs.river.enable = true;

    programs.steam.enable = true;
    programs.steam.remotePlay.openFirewall = true;

    programs.firefox.enable = true;
    programs.firefox.package = pkgs.firefox-devedition;
    programs.firefox.policies.CaptivePortal = false;
    programs.firefox.policies.DisableTelemetry = true;
    programs.firefox.policies.DisableFirefoxStudies = true;
    programs.firefox.policies.DisablePocket = true;
    programs.firefox.policies.DisableFirefoxAccounts = true;
    programs.firefox.policies.DisableAccounts = true;
    programs.firefox.policies.DisableFirefoxScreenshots = true;
    programs.firefox.policies.FirefoxHome = { Pocket = false; Snippets = false; TopSites = false; Highlights = false; };
    programs.firefox.policies.UserMessaging = { ExtensionRecommendations = false; SkipOnboarding = true; };
    programs.firefox.policies.EnableTrackingProtection = { Value = true; Locked = true; Cryptomining = true; Fingerprinting = true; };
    programs.firefox.policies.Extensions.Install = [
        "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
        "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi"
        "https://addons.mozilla.org/firefox/downloads/latest/youtube-shorts-block/latest.xpi"
        "https://addons.mozilla.org/firefox/downloads/latest/image-search-options/latest.xpi"
        "https://addons.mozilla.org/firefox/downloads/latest/translate-web-pages/latest.xpi"
    ];

    programs.firefox.preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = true;
        "extensions.pocket.enabled" = false;
        "extensions.screenshots.disabled" = true;
    };

    environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        MOZ_ENABLE_WAYLAND = "1";
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "22.11"; # Did you read the comment?
}
