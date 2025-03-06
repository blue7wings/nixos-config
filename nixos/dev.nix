{ config, pkgs, ... }:
{
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
  	enable = true;
	setSocketVariable = true;
  };
  environment.systemPackages = with pkgs; [
	git
	vim
	neofetch
	zsh
	htop
	pkgs.php84
	starship
	pkgs.docker
	pkgs.inetutils
	pkgs.python3
	pkgs.python3Packages.requests

  ];
}
