-- ===================================================================
--  Telescope
-- -------------------------------------------------------------------
--  https://github.com/nvim-telescope/telescope.nvim
--  Find, Filter, Preview, Pick. All lua, all the time.
--  workflow
-- -------------------------------------------------------------------
local function builtin(source, opts)
  opts = opts or {}
  require("telescope.builtin")[source](opts)
end

return {
  "nvim-telescope/telescope.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local global_mappings = {
      i = {
        ["<C-n>"] = "cycle_history_next",
        ["<C-p>"] = "cycle_history_prev",
      },
    }
    telescope.setup({
      pickers = {
        find_files = {
          mappings = global_mappings,
        },
        live_grep = {
          mappings = global_mappings,
        },
      },
    })
  end,

  keys = {
    { "<Leader>/",       function() builtin("current_buffer_fuzzy_find") end,                       desc = "Search" },
    { "<Leader><Space>", function() builtin("buffers") end,                                         desc = "Buffers" },
    { "<Leader>fa",      function() builtin("autocommands") end,                                    desc = "Autocommands" },
    { "<Leader>fc",      function() builtin("commands") end,                                        desc = "Commands" },
    { "<Leader>ff",      function() builtin("find_files") end,                                      desc = "Files" },
    { "<Leader>fF",      function() builtin("find_files", { hidden = true, no_ignore = true }) end, desc = "Find all files (including .gitignored)" },
    { "<Leader>fg",      function() builtin("live_grep") end,                                       desc = "Grep" },
    { "<Leader>fh",      function() builtin("help_tags") end,                                       desc = "Help" },
    { "<Leader>fl",      function() builtin("loclist") end,                                         desc = "Location list" },
    { "<Leader>fq",      function() builtin("quickfix") end,                                        desc = "Quickfix list" },
  }
}
