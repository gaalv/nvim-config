# CLAUDE.md

## Project overview

Modular Neovim configuration using lazy.nvim as plugin manager. Supports Java (work), TypeScript/React, Go (personal), and agentic coding with Claude Code.

## Architecture

- `init.lua` — bootstraps lazy.nvim, loads `options`, `keymaps`, `autocmds`, and all plugins from `lua/plugins/`
- `lua/options.lua` — vim options (leader key is space, nerd font enabled, 2-space indent)
- `lua/keymaps.lua` — global keymaps (window navigation, diagnostics, terminal escape)
- `lua/autocmds.lua` — autocommands (yank highlight, TS auto-import, diagnostics config)
- `lua/plugins/*.lua` — each file returns a lazy.nvim plugin spec table
- `ftplugin/java.lua` — nvim-jdtls config, runs automatically for `.java` files

## Conventions

- All plugin files return a table: `return { { 'author/plugin', ... } }`
- Keymaps use `<leader>` prefix grouped by feature: `s` (search), `g` (git), `c` (code), `d` (debug), `n` (notes), `t` (toggle)
- Descriptions follow `[X]keyword` pattern for which-key display
- Plugins should lazy-load via `event`, `ft`, `cmd`, or `keys` when possible
- Profile-aware installs use `vim.env.NVIM_PROFILE == 'work'` (set in .zshrc on work machine)
- Java LSP uses nvim-jdtls (NOT lspconfig) — always configure in `ftplugin/java.lua`
- Other LSPs go in `lua/plugins/lsp.lua` via the `servers` table
- Format with stylua (config in `.stylua.toml`: 2 spaces, 120 col width, single quotes)
- End every lua file with `-- vim: ts=2 sts=2 sw=2 et`
- macOS only — `ftplugin/java.lua` uses `config_mac`

## Adding a new plugin

1. Create `lua/plugins/<name>.lua`
2. Return a lazy.nvim spec table
3. Use lazy-loading (`ft`, `event`, `cmd`, or `keys`)
4. Keymaps should include `desc` for which-key

## Adding a new LSP

1. Add to `servers` table in `lua/plugins/lsp.lua`
2. If profile-specific, wrap in `if not is_work then` / `if is_work then`
3. Add formatter to `lua/plugins/format.lua` if needed

## Testing changes

```bash
# Symlink if not already done
ln -s ~/www/personal/nvim-config ~/.config/nvim

# Open and check for errors
nvim

# Check health
:checkhealth

# Check plugin status
:Lazy

# Check LSP status
:LspInfo

# Check Mason installs
:Mason
```

## Dependencies

- Neovim >= 0.10, Git, Nerd Font, make, Java 17+, Node.js, Go
- Obsidian vault path configured in `lua/plugins/notes.lua`
