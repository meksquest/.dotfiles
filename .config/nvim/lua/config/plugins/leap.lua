-- ===================================================================
--  Leap
-- -------------------------------------------------------------------
--  https://github.com/ggandor/leap.nvim
--  Neovim's answer to the mouse 🦘
--  editing
-- -------------------------------------------------------------------
return {
  "ggandor/leap.nvim",
  cond = false,

  dependencies = {
    { "ggandor/flit.nvim", config = true },
  },

  config = function()
    require('leap').add_default_mappings()
  end,
}
