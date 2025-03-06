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
	#pkgs.code-cursor
        (callPackage /etc/nixos/cursor_0_45_14.nix {})
     	pkgs.home-manager
 	pkgs.brave
	pkgs.teams-for-linux
	pkgs.flameshot
	# pkgs.wechat-uos
	pkgs.httpie
 	pkgs.httpie-desktop
	pkgs.windsurf

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
