{
  extraConfigLua = ''
    local function async_open_file_krita()
        local filename = vim.fn.expand('<cfile>')
        local full_project_filename = os.getenv("VAULT_LOCATION").."/" .. string.gsub(filename, '.png', '.kra')
        -- print(full_project_filename)
        vim.system({'krita', full_project_filename})
    end
    vim.api.nvim_create_user_command('OpenInKrita', async_open_file_krita, {})
  '';
}
