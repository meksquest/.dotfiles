-- ===================================================================
--  Tree
-- -------------------------------------------------------------------
--  https://github.com/nvim-tree/nvim-tree.lua
--  A file explorer tree for neovim written in lua
--  workflow
-- -------------------------------------------------------------------
return {
  "nvim-tree/nvim-tree.lua",

  config = {
    hijack_directories = { enable = false },
  },

  cmd = {
    "NvimTreeToggle",
    "NvimTreeFindFileToggle"
  },

  keys = {
    { "<Leader>ee", "<Cmd>NvimTreeToggle<CR>",         desc = "Root (toggle)" },
    { "<Leader>ef", "<Cmd>NvimTreeFindFileToggle<CR>", desc = "File (toggle)" },
  },
}
