{
    # Enable networking
    networking.networkmanager.enable = true;
    networking.hostName = "nixos"; # Define your hostname.
    networking.defaultGateway.address = "192.168.0.1";
    networking.nameservers = [ "192.168.0.1" ];
    networking.extraHosts = ''
# Global version
# Genshin logging servers (do not remove!)
0.0.0.0 sg-public-data-api.hoyoverse.com
0.0.0.0 log-upload-os.hoyoverse.com

# Some old global logging servers
0.0.0.0 log-upload-os.mihoyo.com
0.0.0.0 overseauspider.yuanshen.com

# Chinese version
# Genshin logging servers (do not remove!)
0.0.0.0 public-data-api.mihoyo.com
0.0.0.0 log-upload.mihoyo.com
    '';

    # networking.wireless.enable = true;    # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [ 24070 27000 ];
    networking.firewall.allowedUDPPorts = [ 28000 ];
    # networking.firewall.allowedUDPPorts = [ 9999 ];
    # Or disable the firewall altogether.
    networking.firewall.enable = false;
}

