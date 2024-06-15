{pkgs, ...}: let
  nnnScript = pkgs.writeShellScript "run-nnn" ''
    #!${pkgs.stdenv.shell}
    NNN_PLUG="z:autojump" NNN_TRASH=1 nnn -a -r -R -A -P p
  '';
in {
  extraPlugins = [pkgs.vimExtraPlugins.nnn-nvim];
  extraConfigLua = ''
    require("nnn").setup({
      picker = {
        cmd = '${nnnScript}',
        style = { border = "rounded" },
        session = "shared",
        offset = true,
      },
    })
  '';
  keymaps = [
    {
      mode = "t";
      key = "<C-b>";
      action = "<cmd>NnnPicker<cr>";
      options = {
        silent = true;
        desc = "Exit nnn";
      };
    }
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
  autoCmd = [
    {
      event = "FileType";
      pattern = "nnn";
      command = "tnoremap <silent> <buffer> <Esc> <cmd>NnnPicker<cr>";
    }
  ];
}
