{pkgs, ...}: {
  extraPlugins = [pkgs.vimExtraPlugins.nnn-nvim];
  extraConfigLua = ''
    require("nnn").setup({
      --picker = {
      --  cmd = '${pkgs.tmux}/bin/tmux new-session "NNN_PLUG=p:preview-tui; exec nnn -Pp"',
      --  style = { border = "rounded" },
      --  session = "shared",
      --  offset = true,
      --},
    })
  '';
  keymaps = [
    {
      mode = "n";
      key = "<C-b>";
      action = "<cmd>NnnPicker<cr>";
      options = {
        silent = true;
        desc = "Run nnn";
      };
    }
  ];
}
