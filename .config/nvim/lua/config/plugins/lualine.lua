-- ===================================================================
--  Lualine
-- -------------------------------------------------------------------
--  https://github.com/nvim-lualine/lualine.nvim
--  A blazing fast and easy to configure neovim statusline plugin written in pure lua.
--  ui
-- -------------------------------------------------------------------
return {
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_c = { function()
        local path = vim.fn.expand("%")

        if #path > 50 then
          path = vim.fn.pathshorten(path)
        end

        if vim.bo.modified then
          vim.cmd("hi lualine_c_normal guifg=#bb5500")
          return path .. " 🚧"
        else
          vim.cmd("hi lualine_c_normal guifg=#cccccc")
          return path
        end
      end },
    }
  }
}
