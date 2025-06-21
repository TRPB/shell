{
  programs.yazi = {
    enable = true;
    settings.yazi = {
      open = {
        run = "xdg-open '$@'";
      };
    };
  };
}
