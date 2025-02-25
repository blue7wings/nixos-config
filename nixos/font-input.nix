{ config, pkgs, ... }:
{
  # i18n.defaultLocale = "zh_CN.UTF-8";

  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      source-code-pro
      hack-font
      jetbrains-mono
    ];
  };

  fonts.fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "Noto Sans Mono CJK SC"
          "Sarasa Mono SC"
          "DejaVu Sans Mono"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
          "Source Han Sans SC"
          "DejaVu Sans"
        ];
        serif = [
          "Noto Serif CJK SC"
          "Source Han Serif SC"
          "DejaVu Serif"
        ];
      };
    };

  i18n.inputMethod = {
    #enabled = "ibus";
    enabled = "fcitx5";
    # 如果用 fcitx5
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
       fcitx5-rime
       fcitx5-chinese-addons
    ];

    #ibus.engines = with pkgs.ibus-engines; [
    #  libpinyin
    #  rime
    #];
  };
}
