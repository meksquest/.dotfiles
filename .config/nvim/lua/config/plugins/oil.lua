-- ===================================================================
--  Oil
-- -------------------------------------------------------------------
--  https://github.com/stevearc/oil.nvim
--  Neovim file explorer: edit your filesystem like a buffer
--  workflow
-- -------------------------------------------------------------------
return {
  'stevearc/oil.nvim',
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,

  config = function()
    -- setup will typically be called automatically, but because I wrote my own config function, need to call it as part of the function
    require("oil").setup()
    vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory with Oil" })
  end
}
-- use
-- `g?` shows list of available commands
-- you can add and edit file names just as if you were in a vim buffer
-- if you `dd` delete a file, then paste it elsewhere in a different directory, it will move the file for you
