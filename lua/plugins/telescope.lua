return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- Override the default find_files to include hidden files
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files({
          hidden = true,
          no_ignore = false,
          follow = true,
        })
      end,
      desc = "Find Files (including hidden)",
    },
    -- Also override space + space (LazyVim's file finder)
    {
      "<leader><leader>",
      function()
        require("telescope.builtin").find_files({
          hidden = true,
          no_ignore = false,
          follow = true,
        })
      end,
      desc = "Find Files (including hidden)",
    },
  },
  opts = function(_, opts)
    opts.defaults = opts.defaults or {}
    opts.defaults.file_ignore_patterns = {
      "^.git/",
      "node_modules/",
    }
    
    opts.pickers = opts.pickers or {}
    opts.pickers.find_files = {
      hidden = true,
      no_ignore = false,
      follow = true,
    }
    
    opts.pickers.live_grep = {
      additional_args = function()
        return { "--hidden" }
      end,
    }
    
    opts.pickers.grep_string = {
      additional_args = function()
        return { "--hidden" }
      end,
    }
    
    return opts
  end,
}
