-- ===================================================================
--  Catppuccin
-- -------------------------------------------------------------------
--  https://github.com/catppuccin/nvim
--   🍨 Soothing pastel theme for (Neo)vim
--  ui
-- -------------------------------------------------------------------
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({})
  end
}
