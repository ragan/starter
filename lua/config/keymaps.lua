-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Multi-word grep: searches for lines containing ALL words in any order
-- Usage: Type "make string go" to find lines with all three words
-- This chains multiple rg calls to ensure all words are present
local function multi_word_grep()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local make_entry = require("telescope.make_entry")

  pickers
    .new({}, {
      prompt_title = "Multi-word Grep (space = AND)",
      finder = finders.new_job(function(prompt)
        if not prompt or prompt == "" then
          return nil
        end

        -- Split prompt into words
        local words = {}
        for word in prompt:gmatch("%S+") do
          table.insert(words, word)
        end

        if #words == 0 then
          return nil
        end

        -- Build chained rg command
        -- First word searches files, subsequent words filter results
        local cmd = {
          "sh",
          "-c",
          string.format(
            "rg --color=never --no-heading --with-filename --line-number --column --smart-case --hidden '%s' %s",
            words[1],
            table.concat(
              vim.tbl_map(function(w)
                return string.format("| rg '%s'", w)
              end, vim.list_slice(words, 2)),
              " "
            )
          ),
        }

        return cmd
      end, make_entry.gen_from_vimgrep({}), nil, nil),
      sorter = conf.generic_sorter({}),
      previewer = conf.grep_previewer({}),
    })
    :find()
end

vim.keymap.set("n", "<leader>sf", multi_word_grep, { desc = "Multi-word Grep (fuzzy)" })
