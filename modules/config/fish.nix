{
  pkgs,
  lib,
  config,
  ...
}:
let
  configHome = config.xdg.configHome;
in
{
  # Fish stores config in a file it neeeds write access to
  # Create the immutable nix file as `fish_variables.default_vars`
  # Then copy it to a writable `fish_variables`
  xdg.configFile."fish/fish_variables.default_vars" = {
    source = ./fish_variables;
    executable = false;
    onChange = ''
      cp ${configHome}/fish/fish_variables.default_vars ${configHome}/fish/fish_variables
      chmod 600 ${configHome}/fish/fish_variables
    '';
  };
  xdg.configFile."fish/conf.d/fish_config.fish".text = ''
     set -U fish_greeting
     set -x SHELL fish
     fish_vi_key_bindings
     set -x fish_vi_cursor 1
     set -x fish_vi_force_cursor 1
     set -gx fish_cursor_default block
     set -gx fish_cursor_insert line
     set -gx fish_cursor_visual block
     set -gx fish_cursor_replace_one underscore
     bind \e --sets-mode insert repaint-mode
     bind \e\[2~ --sets-mode insert repaint-mode
     bind e forward-single-char forward-word backward-char

     set -x originalnvim (which nvim)
     function nvimStart
      if count $argv > /dev/null
        set open ":e $argv"
      else 
        set open ":Alpha"
      end
      if set -q NVIM
          $originalnvim --server $NVIM --remote-send "<C-\\><C-N>:silent tcd $PWD<CR>$open<CR>"
      else
        $originalnvim $argv
      end
    end
    alias nvim='nvimStart'
  '';

  programs.bash = {
    enable = true;
    initExtra = lib.mkAfter ''
      SHELL=${pkgs.fish}/bin/fish
      exec ${pkgs.fish}/bin/fish
    '';
  };
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "Tide";
        src = pkgs.fishPlugins.tide.src;
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf.src;
      }
      {
        name = "fifc";
        src = pkgs.fishPlugins.fifc.src;
      }
    ];
  };
}
