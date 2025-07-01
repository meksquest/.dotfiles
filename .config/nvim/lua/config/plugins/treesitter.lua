-- ===================================================================
--  nvim-treesitter
-- -------------------------------------------------------------------
--  https://github.com/nvim-treesitter/nvim-treesitter
--  Tree-sitter configurations and abstraction layer
--  tree-sitter
-- -------------------------------------------------------------------
local M = { "nvim-treesitter/nvim-treesitter" }

M.dependencies = {
  "nvim-treesitter/playground",
}

M.build = ":TSUpdate"

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "bash",
      "css",
      "diff",
      "elixir",
      "gitignore",
      "vimdoc",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "query",
      "regex",
      "sql",
      "toml",
      "yaml",
      "heex",
      "typescript",
    },
    highlight = { enable = true },
    indent = { enable = true },
  })
end

return M
