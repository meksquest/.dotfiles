------------------------------------------------------------
-- Keyboard Mappings
------------------------------------------------------------

-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local set = vim.keymap.set

set("n", "<Left>", "<C-w>h")
set("n", "<Down>", "<C-w>j")
set("n", "<Up>", "<C-w>k")
set("n", "<Right>", "<C-w>l")

set("n", "<Esc>", "<Cmd>nohlsearch<CR>")

set("n", "<Leader>p", "<Cmd>Lazy<CR>", { desc = "Plugins" })

set("n", "<LocalLeader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })

set("n", "<LocalLeader>s", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>",
  { desc = "Document symbols" })

set('n', '<leader>c', function()
  -- TOGGLE: Change this to switch between filtering modes
  local use_preferred_only = true

  -- Persistence: where to store our data
  local data_path = vim.fn.stdpath('data') .. '/colorscheme_switcher.json'

  -- Load saved data
  local function load_data()
    local file = io.open(data_path, 'r')
    if file then
      local content = file:read('*all')
      file:close()
      local ok, data = pcall(vim.json.decode, content)
      if ok then
        return data
      end
    end
    return { last_scheme = nil, favorites = {} }
  end

  -- Save data
  local function save_data(data)
    local file = io.open(data_path, 'w')
    if file then
      file:write(vim.json.encode(data))
      file:close()
    end
  end

  -- Load our saved data
  local saved_data = load_data()

  -- Helper function to check if scheme is favorited
  local function is_favorite(scheme)
    for _, fav in ipairs(saved_data.favorites) do
      if fav == scheme then
        return true
      end
    end
    return false
  end

  -- Helper function to toggle favorite
  local function toggle_favorite(scheme)
    for i, fav in ipairs(saved_data.favorites) do
      if fav == scheme then
        table.remove(saved_data.favorites, i)
        return false -- removed
      end
    end
    table.insert(saved_data.favorites, scheme)
    return true -- added
  end

  -- Get current colorscheme
  local current = vim.g.colors_name or 'default'

  -- Get all available colorschemes
  local all_schemes = vim.fn.getcompletion('', 'color')

  local schemes = {}

  if use_preferred_only then
    -- INCLUDE MODE: Only show schemes with these prefixes
    local preferred_prefixes = { 'tokyonight', 'catppuccin', 'kanagawa', 'gruvbox', 'nord', 'dracula' }

    for _, scheme in ipairs(all_schemes) do
      for _, prefix in ipairs(preferred_prefixes) do
        if vim.startswith(scheme, prefix) then
          table.insert(schemes, scheme)
          break
        end
      end
    end
  else
    -- EXCLUDE MODE: Show everything except ugly built-ins
    local excluded = { 'default', 'blue', 'darkblue', 'delek', 'desert', 'elflord', 'evening', 'industry', 'koehler',
      'morning', 'murphy', 'pablo', 'peachpuff', 'ron', 'shine', 'slate', 'torte', 'zellner' }

    for _, scheme in ipairs(all_schemes) do
      local should_exclude = false
      for _, excluded_scheme in ipairs(excluded) do
        if scheme == excluded_scheme then
          should_exclude = true
          break
        end
      end
      if not should_exclude then
        table.insert(schemes, scheme)
      end
    end
  end

  -- Try Telescope first, fallback to inputlist
  local has_telescope, telescope = pcall(require, 'telescope')

  if has_telescope then
    -- TELESCOPE MODE with live preview!
    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local conf = require('telescope.config').values
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')

    -- Store original colorscheme to restore if cancelled
    local original_scheme = current

    -- Create display entries with favorite indicators
    local display_schemes = {}
    for _, scheme in ipairs(schemes) do
      local display = scheme
      if is_favorite(scheme) then
        display = "⭐ " .. scheme
      end
      if scheme == saved_data.last_scheme then
        display = display .. " (last used)"
      end
      table.insert(display_schemes, { scheme, display })
    end

    pickers.new({}, {
      prompt_title = 'Color Schemes (current: ' .. current .. ') | <C-f> to favorite',
      finder = finders.new_table({
        results = display_schemes,
        entry_maker = function(entry)
          return {
            value = entry[1],   -- actual scheme name
            display = entry[2], -- display with stars/indicators
            ordinal = entry[1], -- for searching
          }
        end
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        -- Live preview function
        local function preview_colorscheme()
          local selection = action_state.get_selected_entry()
          if selection then
            pcall(vim.cmd.colorscheme, selection.value)
          end
        end

        -- Toggle favorite function (now properly scoped)
        local function toggle_fav()
          local selection = action_state.get_selected_entry()
          if selection then
            local added = toggle_favorite(selection.value)
            save_data(saved_data)
            print((added and "Added to" or "Removed from") .. " favorites: " .. selection.value)
          end
        end

        -- Add favorite toggle mapping
        map('i', '<C-f>', toggle_fav)
        map('n', '<C-f>', toggle_fav)

        -- Override cursor movement to trigger preview
        map('i', '<Down>', function()
          actions.move_selection_next(prompt_bufnr)
          preview_colorscheme()
        end)

        map('i', '<Up>', function()
          actions.move_selection_previous(prompt_bufnr)
          preview_colorscheme()
        end)

        map('i', '<C-n>', function()
          actions.move_selection_next(prompt_bufnr)
          preview_colorscheme()
        end)

        map('i', '<C-p>', function()
          actions.move_selection_previous(prompt_bufnr)
          preview_colorscheme()
        end)

        -- Also handle normal mode navigation
        map('n', 'j', function()
          actions.move_selection_next(prompt_bufnr)
          preview_colorscheme()
        end)

        map('n', 'k', function()
          actions.move_selection_previous(prompt_bufnr)
          preview_colorscheme()
        end)

        -- Apply selection on enter
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if selection then
            vim.cmd.colorscheme(selection.value)
            saved_data.last_scheme = selection.value
            save_data(saved_data)
            print('Applied colorscheme: ' .. selection.value)
          end
        end)

        -- Restore original on escape
        map('i', '<C-c>', function()
          actions.close(prompt_bufnr)
          vim.cmd.colorscheme(original_scheme)
          print('Cancelled - restored: ' .. original_scheme)
        end)

        map('n', '<Esc>', function()
          actions.close(prompt_bufnr)
          vim.cmd.colorscheme(original_scheme)
          print('Cancelled - restored: ' .. original_scheme)
        end)

        return true
      end,
    }):find()

    -- Initial preview of first item
    if #schemes > 0 then
      pcall(vim.cmd.colorscheme, schemes[1])
    end
  else
    -- FALLBACK MODE: Original inputlist with favorites
    local mode_text = use_preferred_only and " (favorites only)" or " (all good themes)"
    local menu = { 'Select color scheme (current: ' .. current .. ')' .. mode_text .. ':' }
    for i, scheme in ipairs(schemes) do
      local display = scheme
      if is_favorite(scheme) then
        display = "⭐ " .. display
      end
      if scheme == saved_data.last_scheme then
        display = display .. " (last used)"
      end
      table.insert(menu, i .. '. ' .. display)
    end

    local user_opt = vim.fn.inputlist(menu)

    if user_opt > 0 and user_opt <= #schemes then
      local selected_scheme = schemes[user_opt]
      vim.cmd.colorscheme(selected_scheme)
      saved_data.last_scheme = selected_scheme
      save_data(saved_data)
      print('Applied colorscheme: ' .. selected_scheme)
    end
  end
end, { desc = 'Switch color schemes' })

-- Restore last used colorscheme on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Load saved data
    local data_path = vim.fn.stdpath('data') .. '/colorscheme_switcher.json'
    local file = io.open(data_path, 'r')
    if file then
      local content = file:read('*all')
      file:close()
      local ok, data = pcall(vim.json.decode, content)
      if ok and data.last_scheme then
        -- Only restore if the saved scheme is actually available
        local available_schemes = vim.fn.getcompletion('', 'color')
        for _, scheme in ipairs(available_schemes) do
          if scheme == data.last_scheme then
            vim.cmd.colorscheme(data.last_scheme)
            print('Restored last colorscheme: ' .. data.last_scheme)
            break
          end
        end
      end
    end
  end,
})
