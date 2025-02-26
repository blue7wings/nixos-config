{ config, pkgs, callPacakage, ... }:

{
  environment.systemPackages = with pkgs; [
    i3
    polybar
  ];

  services.displayManager.defaultSession = "none+i3";
  environment.pathsToLink = [ "/libexec" ];
  services.xserver = {
    enable = true;
    desktopManager = {xterm.enable=false;};
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

