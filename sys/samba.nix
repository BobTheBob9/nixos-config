{
    services.samba-wsdd.enable = true;
    networking.firewall.allowedTCPPorts = [
        5357 # wsdd
    ];
    networking.firewall.allowedUDPPorts = [
        3702 # wsdd
    ];

    services.samba = {
        enable = true;
        openFirewall = true;
          extraConfig = ''
          server string = nixos
          netbios name = nixos
          workgroup = WORKGROUP
          security = user

          # :NOTE| localhost is the ipv6 localhost ::1
          hosts allow = 192.168.0.0/16 localhost
          hosts deny = 0.0.0.0/0
          guest account = nobody
          map to guest = bad user
    '';
        shares = {
            genshin = {
                path = "/mnt/fastgames/anime_temp/Genshin Impact/";
                browseable = "yes";
                "read only" = "no";
                "writeable" = "yes";
                "guest ok" = "yes";
                "force user" = "bobthebob";
                "create mask" = "777";
                "directory mask" = "777";
            };
        };
    };
}
