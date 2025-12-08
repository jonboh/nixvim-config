{
  plugins.noice = {
    enable = true;
    settings = {
      cmdline.view = "cmdline";
      lsp = {
        override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
        progress.enabled = false;
      };
      routes = [
        {
          view = "split";
          filter = {
            event = "msg_show";
            kind = ["shell_out" "shell_err"];
          };
        }
      ];
    };
  };
}
