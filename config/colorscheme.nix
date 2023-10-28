{
  colorschemes.tokyonight = {
    enable = true;
    style = "night";
    transparent = true;
    terminalColors = true;
    dayBrightness = 0;
    dimInactive = true;
    styles = {
      comments = { italic = true; };
      keywords = { italic = false; };
      functions = { };
      variables = { };

    };
  };
  extraConfigLua = ''
    vim.opt.background = "dark"
    vim.api.nvim_set_hl(0, "LineNr", {fg="#B1A6F7"})
    vim.api.nvim_set_hl(0, "CursorLineNr", {fg="#af00af"})
  '';
}
