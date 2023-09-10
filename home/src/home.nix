{ config, pkgs, inputs, ... }:
{
    imports = [
        ./plasma_config.nix
    ];

    nixpkgs.config.allowUnfreePredicate = _: true;

    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "bobthebob";
    home.homeDirectory = "/home/bobthebob";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "22.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages =
    [
        # communication software
        pkgs.discord
        pkgs.slack

        # tools
        pkgs.parsec-bin
        pkgs.obs-studio
        pkgs.qbittorrent
        pkgs.kate
        pkgs.vlc
        pkgs.libreoffice
        pkgs.aseprite
        pkgs.gimp

        # games
        pkgs.osu-lazer-bin
        pkgs.prismlauncher
    
        # games - emulators
        pkgs.dolphin-emu
        pkgs.yuzu-ea

        # games - utilities
        pkgs.protonup-ng # TODO: should declaratively manage
        pkgs.wineWowPackages.unstableFull
        #inputs.nix-gaming.packages.${pkgs.system}.wine-ge # this sucks i think
        pkgs.gamescope

        pkgs.yakuake
        pkgs.btop
    ];

    programs.firefox = {
        enable = true;

        profiles.bobthebob = {
            extensions = with pkgs.nur.repos.rycee.firefox-addons; [
                plasma-integration

                ublock-origin
                sponsorblock
                youtube-shorts-block

                translate-web-pages
                image-search-options

                betterttv
                # TODO: need more ttv extensions, no adblock or 7tv!
        ];
    };

    package = pkgs.firefox-wayland.override { 
        extraPolicies = {
                CaptivePortal = false;
                DisableFirefoxStudies = true;
                DisablePocket = true;
                DisableTelemetry = true;
                DisableFirefoxAccounts = true;

                FirefoxHome = {
                    Pocket = false;
                    Snippets = false;
                };

                UserMessaging = {
                    ExtensionRecommendations = false;
                    SkipOnboarding = true;
                };
            };
        };
    };

    programs.git = {
        enable = true;
        userName = "BobTheBob9";
        userEmail = "for.oliver.kirkham@gmail.com";
    };

    # shortcuts
    xdg.desktopEntries = {
        "Titanium Dev" = {
            name = "Titanium Dev";
            exec = "konsole -e nix develop";
            icon = "system-run";
            settings.Path = "~/repos/titanium";
        };

        "Titanfall 2" = {
            name = "Titanfall 2";
            exec = "env WINEPREFIX=\"/mnt/funny-largentfs/wineprefixes/ea\" wine Z:/mnt/fastgames/origin/titanfall/Titanfall2/Titanfall2.exe";
            icon = "/mnt/fastgames/origin/titanfall/Titanfall2/Titanfall2.ico";
            settings.Categories = "Game";
            settings.Path = "/mnt/funny-largentfs/wineprefixes/ea/dosdevices/z:/mnt/fastgames/origin/titanfall/Titanfall2/";
        };

        "R5Reloaded" = {
            name = "R5Reloaded";
            exec = "env WINEPREFIX=\"/mnt/funny-largentfs/wineprefixes/ea\" wine Z:/mnt/funny-largentfs/r5reloaded/launcher.exe";
            icon = "/mnt/funny-largentfs/r5reloaded/launcher.exe_14_101.ico";
            settings.Categories = "Game";
            settings.Path = "/mnt/funny-largentfs/wineprefixes/ea/dosdevices/z:/mnt/funny-largentfs/r5reloaded/";
        };
    };

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
        # # Building this configuration will create a copy of 'dotfiles/screenrc' in
        # # the Nix store. Activating the configuration will then make '~/.screenrc' a
        # # symlink to the Nix store copy.
        # ".screenrc".source = dotfiles/screenrc;

        # # You can also set the file content immediately.
        # ".gradle/gradle.properties".text = ''
        #   org.gradle.console=verbose
        #   org.gradle.daemon.idletimeout=3600000
        # '';
    };

    # You can also manage environment variables but you will have to manually
    # source
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/bobthebob/etc/profile.d/hm-session-vars.sh
    #
    # if you don't want to manage your shell through Home Manager.
    home.sessionVariables = {
        # EDITOR = "emacs"
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
