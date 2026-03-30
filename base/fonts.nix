{ config, pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Times New Roman" "Noto Serif" ];
        sansSerif = [ "Inter" "Arial" "Noto Sans" ];
        monospace = [ "JetBrainsMono Nerd Font" "Courier New" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

    packages = with pkgs; [
      corefonts           # Times New Roman, Arial, Verdana, etc.
      vista-fonts         # Calibri, Cambria, Consolas
      google-fonts        # Massive collection including Poppins, Montserrat, etc.
      inter               # Modern UI standard
      nerd-fonts.jetbrains-mono # Coding / Terminal
      
      # Compatibility (emojy, chinese characters etc...)
      noto-fonts 
      noto-fonts-cjk-sans # Asian characters
      noto-fonts-emoji
      liberation_ttf
    ];
  };
}
