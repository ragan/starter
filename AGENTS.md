# AGENTS.md

## Repository Type

Personal Neovim configuration built on **LazyVim** (v15) with **lazy.nvim** as the plugin manager and **Mason** for LSP/formatter/linter installation. Written entirely in Lua.

## Build/Lint/Format Commands

- **Format Lua files**: `stylua <file>` (configured in `stylua.toml`)
  - stylua must be installed: `brew install stylua` or via Mason
- **No build step**: Config is loaded directly by Neovim on startup
- **No test suite**: This is a dotfile config, not a library
- **Plugin lockfile**: `lazy-lock.json` tracks pinned plugin versions

### Formatting Rules (from `stylua.toml`)

- Indent: 2 spaces
- Column width: 120 characters

## Code Style Guidelines

### Lua Style

- Use `snake_case` for variables, functions, and local helpers
- Use `camelCase` for Neovim API concepts referenced in code (e.g., `file_ignore_patterns`)
- Plugin specs return a **single table** (or list of tables) per file
- Use `opts = function(_, opts)` pattern when extending existing opts (preserves defaults)
- Use `opts = { ... }` when fully replacing opts
- Comments use `--` (Lua standard), not used heavily beyond section headers

### Plugin Spec Convention

Each file in `lua/plugins/` returns a lazy.nvim plugin spec:

```lua
return {
  "author/plugin-name",
  dependencies = { ... },
  opts = { ... },
  keys = { ... },
  config = function(_, opts) ... end,
}
```

- Override LazyVim defaults by specifying the same plugin name
- Keymaps use the `<leader>` prefix and include `desc` for which-key
- Prefer `keys` table for keymaps over `vim.keymap.set` in `config`

### Import/Require Pattern

- Config modules: `require("config.lazy")`, `require("config.options")`, etc.
- Plugin modules: `require("telescope.builtin")`, `require("remote-sshfs.api")`
- No relative requires; all paths are from `lua/` root

## Project Structure

```
~/.config/nvim/
├── init.lua                    # Entry point, bootstraps lazy.nvim + LazyVim
├── stylua.toml                 # Lua formatter config (2 spaces, 120 col width)
├── .neoconf.json               # lua_ls + neodev settings for editing this config
├── lazyvim.json                # LazyVim extras and version tracking
├── lazy-lock.json              # Pinned plugin commit hashes
├── lua/
│   ├── config/
│   │   ├── lazy.lua            # lazy.nvim setup, plugin spec imports
│   │   ├── options.lua         # vim.g globals, editor settings
│   │   ├── keymaps.lua         # Custom keymaps (multi-word grep, etc.)
│   │   └── autocmds.lua        # Custom autocommands (currently empty)
│   └── plugins/
│       ├── telescope.lua       # Telescope overrides (hidden files, symbol search)
│       ├── neo-tree.lua        # Neo-tree config (show hidden/gitignored files)
│       ├── remote-sshfs.lua    # Remote SSH filesystem integration
│       └── example.lua         # DISABLED (guarded with `if true then return {} end`)
└── .gitignore
```

### Key Files

- `lua/config/lazy.lua` — Plugin manager bootstrap and setup; imports LazyVim defaults then `plugins/` dir
- `lazyvim.json` — Tracks enabled LazyVim extras
- `.neoconf.json` — Configures `lua_ls` for intelligent editing of this Neovim config

## Working with This Repository

### How Changes Take Effect

- Edits to files under `lua/config/` or `lua/plugins/` require restarting Neovim (or running `:Lazy reload <plugin>`)
- Use `:LazyHealth` to diagnose plugin issues
- Use `:Mason` to check/install LSP servers and tools
- Use `:checkhealth` for general health checks

### Adding a Plugin

1. Create or edit a file in `lua/plugins/`
2. Return a lazy.nvim spec table
3. Restart Neovim; lazy.nvim auto-detects new plugin specs

### Adding a LazyVim Extra

1. Run `:LazyExtras` in Neovim and toggle the extra, OR
2. Manually add `"lazyvim.plugins.extras.lang.<name>"` to the `extras` array in `lazyvim.json`
3. Restart Neovim; the extra's plugins will be auto-installed

### Overriding LazyVim Defaults

- To override a plugin's config, create a file in `lua/plugins/` with the same plugin name
- Use `opts = function(_, opts)` to extend (preserves LazyVim defaults)
- Use `opts = { ... }` to fully replace
- Use `enabled = false` to disable a LazyVim plugin

### LSP Servers

Managed via Mason. Currently configured languages:
- **Lua**: `lua_ls` (auto-configured by LazyVim)
- **Python**: `pyright` (set via `vim.g.lazyvim_python_lsp`)
- **Go**: `gopls` (installed via Mason, auto-enabled)
- **TypeScript/JavaScript**: `vtsls` (via enabled `lang.typescript` + `lang.typescript.vtsls` extras)
- **Docker**: via `lang.docker` extra
- **JSON**: via `lang.json` extra (includes SchemaStore.nvim)
- **Ember**: via `lang.ember` extra
- **Markdown**: via `lang.markdown` extra

### Formatters

- **Lua**: `stylua` (configured in `stylua.toml`)
- **JS/TS/HTML/CSS**: `prettier` (installed via Mason)
- **Shell**: `shfmt` (installed via Mason)
- Managed via `conform.nvim`

## Additional Notes

- `example.lua` in `plugins/` is intentionally disabled (`if true then return {} end`); do not remove it as it serves as reference
- Neo-tree and Telescope are configured to show hidden files by default
- Remote SSH editing is set up via `remote-sshfs.nvim` with `<leader>r` prefix keymaps
- The `<leader>sf` keymap provides multi-word AND grep (chains ripgrep calls)
- Theme: Catppuccin (installed) with TokyoNight as fallback
- `vim.g.snacks_animate = false` disables Snacks animations
