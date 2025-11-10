return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
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
    -- Search for symbols in current buffer
    {
      "<leader>fs",
      function()
        require("telescope.builtin").lsp_document_symbols()
      end,
      desc = "Find Symbols (current file)",
    },
    -- Search for symbols in entire workspace
    {
      "<leader>fS",
      function()
        require("telescope.builtin").lsp_workspace_symbols()
      end,
      desc = "Find Symbols (workspace)",
    },
    -- Search for symbols dynamically (as you type)
    {
      "<leader>fd",
      function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols()
      end,
      desc = "Find Symbols (dynamic)",
    },
    -- Search using ctags (if you have a tags file)
    {
      "<leader>ft",
      function()
        require("telescope.builtin").tags()
      end,
      desc = "Find Tags (ctags)",
    },
    -- Search for current word as symbol
    {
      "<leader>fw",
      function()
        require("telescope.builtin").grep_string()
      end,
      desc = "Find Word under cursor",
    },
    -- Fuzzy grep - search with multiple keywords in any order
    {
      "<leader>sf",
      function()
        require("telescope.builtin").live_grep({
          additional_args = function()
            return { "--hidden" }
          end,
          -- This allows fuzzy matching on results
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
          },
        })
      end,
      desc = "Fuzzy Grep (multi-word)",
    },
  },
  opts = function(_, opts)
    opts.defaults = opts.defaults or {}
    opts.defaults.file_ignore_patterns = {
      "^.git/",
      "node_modules/",
    }
    
    -- Configure fzf for better fuzzy finding
    opts.defaults.sorting_strategy = "ascending"
    opts.defaults.layout_config = {
      prompt_position = "top",
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
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    -- Load fzf extension for better fuzzy finding
    telescope.load_extension("fzf")
  end,
}
