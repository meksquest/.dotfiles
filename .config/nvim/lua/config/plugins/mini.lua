-- ===================================================================
--  Mini
-- -------------------------------------------------------------------
--  https://github.com/echasnovski/mini.nvim
--  Library of 40+ independent Lua modules improving overall Neovim (version 0.9 and higher) experience with minimal effort
--  workflow
-- -------------------------------------------------------------------
return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.align").setup()
    require("mini.comment").setup({})
    require("mini.pairs").setup({})
  end
}
