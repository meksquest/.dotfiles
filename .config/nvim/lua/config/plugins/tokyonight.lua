-- ===================================================================
--  Tokyonight
-- -------------------------------------------------------------------
--  https://github.com/folke/tokyonight.nvim
--  A clean, dark Neovim theme written in Lua, with support for lsp, treesitter and lots of plugins. Includes additional themes for Kitty, Alacritty, iTerm and Fish.
--  ui
-- -------------------------------------------------------------------
local M = { "folke/tokyonight.nvim" }

function M.config()
  require("tokyonight").setup({
    style = "night",
  })

  -- Sets the default colorscheme
  vim.cmd.colorscheme("tokyonight")
end

return M
