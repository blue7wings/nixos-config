# /etc/nixos/home.nix
{ config, pkgs, ... }:

{
  home-manager.users.liam = { pkgs, ... }: {
    # Home Manager 配置
    home.stateVersion = "23.11"; # 指定 Home Manager 版本

    # 安装用户级软件包
    home.packages = with pkgs; [
      #zsh-powerlevel10k
    ];

    # 其他配置，例如 Zsh
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "z" ];
        #theme = "powerlevel10k/powerlevel10k";
      };
      initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      	[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';
    };
  };
}
