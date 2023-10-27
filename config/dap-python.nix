{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.nvim-dap-python
  ];
  extraConfigLua = ''
    require('dap-python').setup('python')
    table.insert(require('dap').configurations.python, {
      type = 'python',
      request = 'launch',
      name = 'My custom launch configuration',
      program =  "''${file}",
      -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
    })
  '';
}
