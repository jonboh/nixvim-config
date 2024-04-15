{
  extraConfigLua = ''
    P = function(v) -- tj easy printing
        print(vim.inspect(v))
        return v
    end

    W = function(v, filename)
      local file = io.open(filename or 'stdout_nvim_lua', 'a') -- Open the file in append mode
      file:write(vim.inspect(v))
      file:close()
    end
  '';
}
