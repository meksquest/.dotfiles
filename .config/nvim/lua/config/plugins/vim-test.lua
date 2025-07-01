-- ===================================================================
--  VimTest
-- -------------------------------------------------------------------
--  https://github.com/vim-test/vim-test
--   Run your tests at the speed of thought
--  testing
-- -------------------------------------------------------------------
return {
  "vim-test/vim-test",

  config = function()
    -- lua
    vim.g["test#strategy"] = 'floaterm'
    -- vim script
    -- let test#strategy = 'floaterm'
    -- can do the below, runs literal vimscript
    -- vim.cmd("let test#script = 'floaterm'")
  end,
  dependencies = { 'voldikss/vim-floaterm' },
  keys = {
    { "<Leader>tn", "<Cmd>TestNearest<CR>", desc = "Test nearest" },
    { "<Leader>tt", "<Cmd>TestLast<CR>" },
    { "<Leader>tf", "<Cmd>TestFile<CR>" }
  }
}
