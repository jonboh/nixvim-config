{
  extraConfigLua = ''
    P = function(v) -- tj easy printing
        print(vim.inspect(v))
        return v
    end
  '';
}
