{pkgs, ...}: {
  plugins.conform-nvim = {
    enable = true;

    settings = {
      formatters = {
        alejandra.command = "${pkgs.alejandra}/bin/alejandra";
        rustfmt.command = "${pkgs.rustfmt}/bin/rustfmt";
        isort.command = "${pkgs.python311Packages.isort}/bin/isort";
        ruff_format.command = "${pkgs.ruff}/bin/ruff";
        jq.command = "${pkgs.jq}/bin/jq";
        taplo.command = "${pkgs.taplo}/bin/taplo";
        yamlfmt.command = "${pkgs.yamlfmt}/bin/yamlfmt";
        stylua = {
          command = "${pkgs.stylua}/bin/stylua";
          args = ["--indent-type" "Spaces" "--indent-width" "2" "--column-width" "100" "--sort-requires"];
        };
        prettier.command = "${pkgs.nodePackages.prettier}/bin/prettier";
        sql-formatter = {
          command = "${pkgs.nodePackages.sql-formatter}/bin/sql-formatter";
          args = [
            "--config"
            "${pkgs.writeText "conform-sql-config.json" ''
              {
                "tabWidth": 2,
                "linesBetweenQueries": 2,
                "keywordCase": "upper",
                "dataTypeCase": "upper",
                "identifierCase": "lower"
              }''}"
          ];
        };
        sql-formatter-mysql = {
          command = "${pkgs.nodePackages.sql-formatter}/bin/sql-formatter";
          args = [
            "--config"
            "${pkgs.writeText "conform-sql-config.json" ''
              {
                "language": "mysql",
                "tabWidth": 2,
                "linesBetweenQueries": 2,
                "keywordCase": "upper",
                "dataTypeCase": "upper",
                "identifierCase": "lower"
              }''}"
          ];
        };
        # NOTE: runic shared env needs to be installed: https://github.com/fredrikekre/Runic.jl?tab=readme-ov-file#quick-start
        runic = {
          command = "julia";
          args = [
            "--startup-file=no"
            "--project=@runic"
            "-e"
            "using Runic; exit(Runic.main(ARGS))"
          ];
        };
      };
      formatters_by_ft = {
        nix = ["alejandra"];
        rust = ["rustfmt"];
        python = ["isort" "ruff_format"];
        json = ["jq"];
        toml = ["taplo"];
        yaml = ["yamlfmt"];
        lua = ["stylua"];
        html = ["prettier"];
        sql = ["sql-formatter"];
        mysql = ["sql-formatter-mysql"];
        julia = ["runic"];
        "*" = ["trim_whitespace"];
      };
      format_on_save = ''
        function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          -- Handle slow formatters
          if _conform_slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end
          local function on_format(err)
            if err and err:match("timeout$") then
              _conform_slow_format_filetypes[vim.bo[bufnr].filetype] = true
            end
          end

          return { timeout_ms = 200, lsp_fallback = false }
        end
      '';

      settings.format_after_save = ''
        function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          if not _conform_slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end
          return { lsp_fallback = false }
        end
      '';
    };
  };
  extraConfigLua = ''
    -- Set Format commands
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_fallback = true, range = range })
    end, { range = true })

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })

    -- Make slow formatters automatically async. Generate storage table
    -- see formatOnSave and formatAfterSave
    _conform_slow_format_filetypes = {}
  '';
}
