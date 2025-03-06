{ config, pkgs, ... }:

{
  home.stateVersion = "24.11";

  home.username = "liam";  
  home.homeDirectory = "/home/liam";

  fonts.fontconfig.enable = true;
  # 鼠标指针大小
  home.pointerCursor = {
    gtk.enable = true;  # Enable GTK cursor support
    x11.enable = true;  # Enable X11 cursor support (for X sessions)
    name = "Adwaita";   # Cursor theme name (replace with your preferred theme)
    package = pkgs.gnome.adwaita-icon-theme;  # Package providing the theme
    size = 32;          # Cursor size in pixels (e.g., 24, 32, 48, 64)
  };

  home.file = {
    # 复制整个字体文件夹
    ".local/share/fonts" = {
      source = "${config.home.homeDirectory}/.config/home-manager/fonts";
      recursive = true; 
    };
    ".config/Cursor/User/settings.json" = {
      source = "${config.home.homeDirectory}/.config/home-manager/cursor/settings.json";
    };
    ".config/Cursor/User/keybindings.json" = {
      source = "${config.home.homeDirectory}/.config/home-manager/cursor/keybindings.json";
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 18.0;
        
        bold = {
          family = "DejaVu Sans Mono";
          style = "Regular";
        };
        
        bold_italic = {
          family = "DejaVu Sans Mono";
          style = "Italic";
        };
        
        italic = {
          family = "DejaVu Sans Mono";
          style = "Italic";
        };
        
        normal = {
          family = "DejaVu Sans Mono";
          style = "Regular";
        };
        
        offset = {
          x = 0;
          y = 1;
        };
        
        glyph_offset = {
          x = 0;
          y = 1;
        };
      };
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;   
    settings = {
      # 自定义 Starship 提示符（相当于 starship.toml 的内容）
      add_newline = true;
      username = {
        show_always = true;
        style_user = "blue bold";
        style_root = "red bold";
      };
      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
      };
      battery = {
        disabled = true;  # 禁用电池显示
      };
    };
  };
 
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true; # 启用历史建议
    enableCompletion = true;       # 启用补全
  };
  
}
