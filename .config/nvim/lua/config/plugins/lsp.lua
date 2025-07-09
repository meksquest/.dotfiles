-- ===================================================================
--  LSP
-- -------------------------------------------------------------------
--  https://github.com/neovim/nvim-lspconfig
--  Quickstart configs for Nvim LSP
--  workflow
-- -------------------------------------------------------------------
local M = { "neovim/nvim-lspconfig" }

function M.config()
  vim.lsp.config("lexical", {
    -- HACK: Portability smell
    cmd = { vim.env.HOME .. "/Code/lexical/_build/dev/package/lexical/bin/start_lexical.sh" }

  })
  vim.lsp.enable { "bashls", "gleam", "lexical", "lua_ls", "ts_ls" }
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      local buffer = event.buf

      -- Auto-format on save if the client supports formatting
      if client and client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = buffer,
          callback = function()
            vim.lsp.buf.format()
          end,
        })
      end

      local telescope = require("telescope.builtin")

      local mappings = {
        ["<LocalLeader>"] = {
          name = "lsp",

          S = { telescope.lsp_workspace_symbols, "Symbols" },
          d = { vim.diagnostic.open_float, "Diagnostics" },
          r = { telescope.lsp_references, "References" },
          s = { telescope.lsp_document_symbols, "Symbols" },
        },
      }

      require("which-key").register(mappings, { buffer = event.buffer })
    end,
  })
end

return M
