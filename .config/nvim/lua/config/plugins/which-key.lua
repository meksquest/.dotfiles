-- ===================================================================
--  WhichKey
-- -------------------------------------------------------------------
--  https://github.com/folke/which-key.nvim
--  Show available keybindings as you type
--  ui
-- -------------------------------------------------------------------
local M = { "folke/which-key.nvim" }

function M.config()
  require("which-key").setup()

  require("which-key").add({
    { "<Leader>?", "<Cmd>WhichKey<CR>", desc = "Keys" },
    { "<Leader>e", group = "explore" },
    { "<Leader>f", group = "find" },
    { "<Leader>a", group = "AI" },
  })
end

return M
