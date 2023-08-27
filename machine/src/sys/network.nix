{
    # Enable networking
    #networking.networkmanager.enable = false;
    networking.hostName = "nixos"; # Define your hostname.
    networking.defaultGateway.address = "192.168.0.1";
    networking.nameservers = [ "192.168.0.1" ];
    # networking.wireless.enable = true;    # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ 9999 ];
    # networking.firewall.allowedUDPPorts = [ 9999 ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
}

