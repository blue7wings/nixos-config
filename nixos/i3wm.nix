{ config, pkgs, callPacakage, ... }:

{
  services.displayManager.defaultSession = "none+i3";
  environment.pathsToLink = [ "/libexec" ];
  services.xserver = {
    enable = true;
    desktopManager = {xterm.enable=false;};
    #displayManager = {
      #defaultSession = "none+i3";
    #};
    windowManager.i3 = {
      package = pkgs.i3-gaps;
      enable = true;
      configFile = "/etc/nixos/i3wm.conf";
      extraPackages = with pkgs; [
	rofi
	polybar
      ];
    };
  };
}

