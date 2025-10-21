{pkgs, ...}: {
  extraPlugins = [(pkgs.callPackage ../plugins/adopure.nix {})];
  extraConfigLua = ''
    vim.g.adopure = {}

    local nio = require("nio")
    nio.run(function()
        local secret_job = nio.process.run({ cmd = "pass", args = { "show", "azure-pat"} })
        vim.g.adopure = { pat_token = secret_job.stdout.read():sub(1, -2) }
    end)

  '';

  plugins.diffview.enable = true;
}
