# nvim-config

Modular Neovim configuration for TypeScript/React, Go and agentic coding workflows.
Inspired by [Lazar Nikolov's](https://github.com/nikolovlazar/dotfiles) setup.

## Requirements

- Neovim >= 0.10
- Git
- [Nerd Font](https://www.nerdfonts.com/) installed and set in your terminal
- `make` (for telescope-fzf-native)
- Node.js (for TypeScript/React LSPs)
- Go (for gopls)
- [lazygit](https://github.com/jesseduffield/lazygit) (for git UI)

## Installation

### 1. Clone the repo

```bash
git clone https://github.com/gaalv/nvim-config.git ~/www/personal/nvim-config
```

### 2. Backup and symlink

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.bak

# Clear Neovim cache/state from old config
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak

# Symlink
ln -s ~/www/personal/nvim-config ~/.config/nvim
```

### 3. Open Neovim

```bash
nvim
```

Plugins install automatically on first launch. Run `:checkhealth` to verify everything is working.

## Structure

```
init.lua                  Bootstrap lazy.nvim, load core modules
lua/
  options.lua             Vim options (leader, indentation, UI)
  keymaps.lua             Global keymaps
  autocmds.lua            Autocommands and diagnostics config
  plugins/
    editor.lua            gitsigns, which-key, mini.nvim, todo-comments, catppuccin
    telescope.lua         Fuzzy finder + LSP pickers
    lsp.lua               Mason + lspconfig (vtsls, gopls, tailwindcss, lua_ls)
    completion.lua        blink.cmp + LuaSnip
    treesitter.lua        Syntax highlighting + auto-install parsers
    format.lua            conform.nvim (prettier)
    lualine.lua           Statusline
    explorer.lua          snacks.explorer (file tree with compact folders)
    diffview.lua          Git diff viewer
    lazygit.lua           LazyGit integration
    trouble.lua           Better diagnostics list
    grug-far.lua          Project-wide search & replace
    avante.lua            AI coding assistant (Claude)
    terminal.lua          toggleterm (floating terminal)
    autopairs.lua         Auto-close brackets/quotes
    notes.lua             obsidian.nvim (Zettelkasten + Obsidian Sync)
```

## Key bindings

### General

| Key | Action |
|---|---|
| `<leader>sf` | Search files |
| `<leader>sg` | Search by grep |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Search & replace (grug-far) |
| `<leader><leader>` | Find buffers |
| `<leader>/` | Fuzzy search in current buffer |
| `<leader>e` | Toggle file explorer |
| `<leader>f` | Format buffer |
| `<C-\>` | Toggle floating terminal |

### LSP

| Key | Action |
|---|---|
| `grd` | Go to definition |
| `gri` | Go to implementation |
| `grr` | Go to references |
| `grt` | Go to type definition |
| `grn` | Rename symbol |
| `gra` | Code action |
| `gO` | Document symbols |
| `gW` | Workspace symbols |
| `<leader>th` | Toggle inlay hints |

### Code (Trouble)

| Key | Action |
|---|---|
| `<leader>cD` | All diagnostics |
| `<leader>cd` | Buffer diagnostics |
| `<leader>cs` | Document symbols |
| `<leader>cl` | LSP definitions/references |

### Git

| Key | Action |
|---|---|
| `<leader>gg` | LazyGit |
| `<leader>gd` | Open diff view |
| `<leader>gh` | File history |
| `<leader>gH` | Branch history |
| `<leader>gq` | Close diff view |

### Notes (Obsidian)

| Key | Action |
|---|---|
| `<leader>nn` | New note |
| `<leader>ns` | Search notes |
| `<leader>nq` | Quick switch |
| `<leader>nd` | Daily notes |
| `<leader>nt` | Insert template |
| `<leader>nl` | Links |
| `<leader>nb` | Backlinks |
| `<leader>nc` | Toggle checkbox |

## Obsidian vault

Update the vault path in `lua/plugins/notes.lua` to match your setup. Sync via `obsidian-headless` is enabled by default.

## Avante (AI)

Set your Anthropic API key:

```bash
export ANTHROPIC_API_KEY=your-key-here
```
