{pkgs, ...}: {
  config = {
    options = {
      # folding
      foldenable = true;
      foldlevel = 99;
      foldlevelstart = 99;
      foldcolumn = "1";
    };
    # had to use ufo-nvim nightly to work with nvim nightly
    extraPlugins = [pkgs.vimPlugins.promise-async (pkgs.callPackage ../plugins/ufo-nvim.nix {})];

    extraConfigLua = ''
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
        vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
        vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)

        local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (' 󰁂 %d '):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, {chunkText, hlGroup})
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, {suffix, 'MoreMsg'})
            return newVirtText
        end

        local ftMap = {
            vim = {'indent'},
            git = ""
        }

        -- lsp->treesitter->indent
        local function customizeSelector(bufnr)
          local function handleFallbackException(err, providerName)
              if type(err) == 'string' and err:match('UfoFallbackException') then
                  return require('ufo').getFolds(providerName, bufnr)
              else
                  return require('promise').reject(err)
              end
          end

          return require('ufo').getFolds('lsp', bufnr):catch(function(err)
              return handleFallbackException(err, 'treesitter')
          end):catch(function(err)
              return handleFallbackException(err, 'indent')
          end)
      end
        require('ufo').setup({

            open_fold_hl_timeout = 0,
            close_fold_kinds_for_ft = {
                default = {'imports', 'comment'},
            },

            fold_virt_text_handler = handler,

            provider_selector = function(bufnr, filetype, buftype)
                return ftMap[filetype] or customizeSelector
            end
        })
    '';
  };
}
