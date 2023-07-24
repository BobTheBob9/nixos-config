This is my current nixos config, with a makefile to configure it :D it's super useful for turning different options on and off, even if it is a bit jank  
run `make && sudo make install_switch` to install to /etc/nixos and rebuild, all the other makefile targets should be pretty self explanatory if you read the file  
  
TODO:  
need better organisation between home-manager and machine configs + makefile for home-manager  
documentation on common configs! e.g. enabling/disabling amd/nvidia, and stuff like that  
generally making things more flexible
