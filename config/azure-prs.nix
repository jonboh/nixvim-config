{pkgs, ...}: {
  extraPlugins = [(pkgs.callPackage ../plugins/adopure.nix {})];
  extraConfigLua = ''
    vim.g.adopure = {}

    local function reload_azure_pat()
      local nio = require("nio")
      nio.run(function()
        local check_vault_job = nio.process.run({ cmd = "is_vault_unlocked", args= { "jon@jonboh.dev" }})
        if check_vault_job.stdout.read() == "" then
            vim.notify("pass vault is locked. Could not retrieve Azure PAT.", vim.log.levels.WARN)
        else
            local secret_job = nio.process.run({ cmd = "pass", args = { "show", "azure-pat"} })
            vim.g.adopure = { pat_token = secret_job.stdout.read():sub(1, -2) }
        end
      end)
    end

    -- Initial load
    local ok, err = pcall(reload_azure_pat)
    if not ok then
      print("AdoPure initialization error: " .. tostring(err))
    end

    -- Create command to reload PAT
    vim.api.nvim_create_user_command('AdoPurePatReload', reload_azure_pat, {})
  '';

  plugins.diffview.enable = true;
}
