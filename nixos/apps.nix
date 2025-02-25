{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
	google-chrome
	vscode
	sublime4
	keyd # key remap 
        alacritty
        pkgs.arandr
        pkgs.xorg.xrandr
	pkgs.code-cursor
     	pkgs.home-manager
	pkgs.opera
  ];
  
  services.keyd = {
     	enable = true;
	keyboards = {
		default = {
		    ids = [ "*" ];
		    settings = {
		      main = {
			capslock = "overload(control)";
		      };
		      control = {
			  j = "down";
			  h = "left";
			  k = "up";
			  l = "right";
		     };
		    };
		  };
	};
  };
}
