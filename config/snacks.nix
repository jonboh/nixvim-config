{
  plugins.snacks = {
    enable = true;
    settings = {
      bigfile.enable = true;
      input.enable = true;
      picker.enable = true;
      notifier.enable = true;
      terminal.enable = true;
    };
  };

  userCommands = {
    Notifications = {
      command.__raw = ''Snacks.notifier.show_history'';
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "z=";
      action = "<cmd>lua Snacks.picker.spelling()<cr>";
    }
  ];
}
