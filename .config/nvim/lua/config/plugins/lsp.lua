-- ===================================================================
--  LSP
-- -------------------------------------------------------------------
--  https://github.com/neovim/nvim-lspconfig
--  Quickstart configs for Nvim LSP
--  workflow
-- -------------------------------------------------------------------
local M = { "neovim/nvim-lspconfig" }

M.dependencies = {
  "folke/neodev.nvim",
  "williamboman/mason-lspconfig.nvim",
  "williamboman/mason.nvim",
}

function M.config()
  local servers = {
    bashls = {},
    lexical = {},
    lua_ls = {
      Lua = {
        telemetry = { enable = false },
        workspace = { checkThirdParty = false },
      },
    },
    ts_ls = {},  -- TypeScript/JavaScript language server
    eslint = {}, -- ESLint for linting
  }

  require("neodev").setup({})
  require("mason").setup()

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  local mason_lspconfig = require("mason-lspconfig")

  mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
  })

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

        ["[d"] = { vim.lsp.diagnostic.goto_prev, "Prev diagnostic" },
        ["]d"] = { vim.lsp.diagnostic.goto_next, "Next diagnostic" },
      }

      require("which-key").register(mappings, { buffer = event.buffer })
    end,
  })
end

return M
