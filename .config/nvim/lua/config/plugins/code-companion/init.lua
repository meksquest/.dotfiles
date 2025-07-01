-- ===================================================================
--  CodeCompanion
-- -------------------------------------------------------------------
--  https://github.com/olimorris/codecompanion.nvim
--  ✨ AI-powered coding, seamlessly in Neovim
--  generative-ai
-- -------------------------------------------------------------------
return {
  "olimorris/codecompanion.nvim",
  opts = {
    display = {
      chat = {
        diff = {
          provider = "mini_diff"
        }
      }
    },
    strategies = {
      chat = {
        adapter = {
          name = "copilot",
          model = "claude-sonnet-4",
        },
      },
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          show_result_in_chat = true, -- Show mcp tool results in chat
          make_vars = true,           -- Convert resources to #variables
          make_slash_commands = true, -- Add prompts as /slash commands
        }
      }
    }
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  init = function()
    -- my path to the plugin starting from the lua file
    require("config.plugins.code-companion.fidget"):init()
  end,
  --
  keys = {
    { "<leader>ac",  "<cmd>CodeCompanionChat<cr>",      desc = "Open CodeCompanionChat" },
    { "<leader>ae",  "<cmd>CodeCompanion /explain<cr>", desc = "CodeCompanion /explain", mode = { "v", "n" } },
    { "<leader>af",  "<cmd>CodeCompanion /fix<cr>",     desc = "CodeCompanion /fix",     mode = { "v", "n" } },
    { "<leader>al",  "<cmd>CodeCompanion /lsp<cr>",     desc = "CodeCompanion /lsp",     mode = { "v", "n" } },
    { "<leader>at",  "<cmd>CodeCompanion /test<cr>",    desc = "CodeCompanion /test",    mode = { "v", "n" } },
    -- open lazy, "[shift]C" to open multi line commit message, " aci" to open the chat, give it #buffer and @insert_and_edit_file to allow it to update the commit log
    { "<leader>aci", "<cmd>CodeCompanion /commit<cr>",  desc = "CodeCompanion /commit",  mode = { "v", "n" } },
  }
}
