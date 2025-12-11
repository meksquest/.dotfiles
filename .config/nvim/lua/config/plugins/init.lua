return {
  {
    "voldikss/vim-floaterm",
    config = function()
      vim.g.floaterm_width = 0.9
      vim.g.floaterm_height = 0.9
    end,
    keys = {
      { "<Leader>g", "<cmd>FloatermNew lazygit<cr>", desc = "Open lazygit in Floaterm" }
    }
  },

  -- Editing
  "tpope/vim-surround",
  {
    'laytan/tailwind-sorter.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
    build = 'cd formatter && npm i && npm run build',
    config = {
      on_save_enabled = true,
      on_save_pattern = { "*.heex", "*.ex" }
    },
    -- Remove trailing white space on save
    {
      "mcauley-penney/tidy.nvim",
      config = {
        filetype_exclude = { "markdown", "diff" }
      },
      init = function()
        vim.keymap.set('n', "<leader>te", require("tidy").toggle, {})
      end
    }
  },

  -- Navigation
  "andymass/vim-matchup",
  "justinmk/vim-dirvish",
  { "folke/trouble.nvim",        config = true },

  -- Syntax
  "sheerun/vim-polyglot",

  -- Source Control
  {
    "lewis6991/gitsigns.nvim",
    config = {
      current_line_blame = false,
    },
    init = function()
      vim.keymap.set('n', "[h", function()
        require("gitsigns").prev_hunk()
      end, { desc = "previous hunk" })
      vim.keymap.set('n', "]h", function()
        require("gitsigns").next_hunk()
      end, { desc = "next hunk" })
      vim.keymap.set('n', "[H", function()
        require("gitsigns").prev_hunk({ navigation_message = false, count = vim.v.count1, target = "first" })
      end, { desc = "first hunk" })
      vim.keymap.set('n', "]H", function()
        require("gitsigns").next_hunk({ navigation_message = false, count = vim.v.count1, target = "last" })
      end, { desc = "last hunk" })
      vim.keymap.set("n", "<leader>gp", require("gitsigns").preview_hunk, { desc = "preview hunk" })
      vim.keymap.set("n", "<leader>gr", require("gitsigns").reset_hunk, { desc = "reset hunk" })
      vim.keymap.set("n", "<leader>gP", require("gitsigns").preview_hunk_inline, { desc = "preview hunk inline" })
    end
  },
  "tpope/vim-fugitive",

  -- Miscellaneous
  { "NvChad/nvim-colorizer.lua", config = true },
  "tpope/vim-repeat",
  "tpope/vim-rsi",
  "tpope/vim-unimpaired",

  -- Trying it out!
  "tpope/vim-projectionist",
  -- The below is meant to go in the root of the directory for any elixir project called `projectionist.json` and this file is globally ignored
  -- gives acces to things like `AV` to open the corresponding test or file
  -- {
  --   "lib/*.ex": {
  --     "alternate": "test/{}_test.exs",
  --     "type": "source",
  --     "template": [
  --       "defmodule {camelcase|capitalize|dot} do",
  --       "end"
  --     ]
  --   },
  --   "test/*_test.exs": {
  --     "alternate": "lib/{}.ex",
  --     "type": "test",
  --     "template": [
  --       "defmodule {camelcase|capitalize|dot}Test do",
  --       "  use ExUnit.Case, async: true",
  --       "",
  --       "  alias {camelcase|capitalize|dot}",
  --       "end"
  --     ]
  --   }
  -- }

  {
    "stevearc/conform.nvim",
    opts = { format_on_save = { lsp_format = "fallback" } }
  },

  -- Fidget
  { "j-hui/fidget.nvim", opts = {} },

  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  -- AI Integration
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      preview = {
        filetypes = { "markdown", "codecompanion" },
        ignore_buftypes = {},
      },
    },
  },
  -- meta plugin for moar plugins
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      indent = {
        enabled = true,
        scope = {
          -- change the line highlight color
          -- "<cmd>hi" to see list of available colors
          hl = "Statement"
        }
      },
    },
  }

  -- Trying out AI copilot
  -- { "github/copilot.vim" }
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = false,
  --   version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  --   opts = {},
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   -- build is a special key for running a shell command after it runs the plugine command
  --   build = "make",
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- }
}
