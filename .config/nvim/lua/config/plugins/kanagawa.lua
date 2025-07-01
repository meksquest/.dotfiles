-- ===================================================================
--  Kanagawa
-- -------------------------------------------------------------------
--  https://github.com/ggandor/leap.nvim
--  NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
--  ui
-- -------------------------------------------------------------------
return {
  "rebelot/kanagawa.nvim",
  priority = 1000,
  config = function()
    require("kanagawa").setup({})
  end
}
