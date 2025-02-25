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
	btop
	pkgs.php84
	starship
	pkgs.docker
  ];
}
