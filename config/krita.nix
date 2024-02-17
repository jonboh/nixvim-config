{
  extraConfigLua = ''
    local function open_file_krita()
        local filename = vim.fn.expand('<cfile>')
        local full_project_filename = os.getenv("VAULT_LOCATION").."/" .. string.gsub(filename, '.png', '.kra')
        vim.cmd('!krita ' .. vim.fn.shellescape(full_project_filename))
    end
    local function async_open_file_krita()
        local filename = vim.fn.expand('<cfile>')
        local full_project_filename = os.getenv("VAULT_LOCATION").."/" .. string.gsub(filename, '.png', '.kra')
        print(full_project_filename)
        vim.cmd('AsyncRun krita ' .. vim.fn.shellescape(full_project_filename))
    end
    vim.api.nvim_create_user_command('OpenInKritaAsync', async_open_file_krita, {})
    vim.api.nvim_create_user_command('OpenInKrita', open_file_krita, {})
  '';
}
