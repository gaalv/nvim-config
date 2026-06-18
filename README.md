# nvim-config

Modular Neovim configuration for Java, TypeScript/React, Go and agentic coding workflows.

## Requirements

- Neovim >= 0.10
- Git
- [Nerd Font](https://www.nerdfonts.com/) installed and set in your terminal
- `make` (for telescope-fzf-native)
- Java 17+ (for jdtls)
- Node.js (for TypeScript/React LSPs)
- Go (for gopls)

## Installation

### 1. Clone the repo

```bash
# Personal machine
git clone git@github.com:gaalv/nvim-config.git ~/www/personal/nvim-config

# Work machine (or wherever you keep projects)
git clone git@github.com:gaalv/nvim-config.git ~/nvim-config
```

### 2. Backup and symlink

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.bak

# Clear Neovim cache/state from old config
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak

# Symlink — adjust the source path to where you cloned
ln -s ~/www/personal/nvim-config ~/.config/nvim    # personal
# OR
ln -s ~/nvim-config ~/.config/nvim                  # work
```

### 3. Set machine profile (work only)

Add to your `~/.zshrc`:

```bash
export NVIM_PROFILE=work
```

This controls what Mason installs:
- **work** — installs jdtls, java-debug-adapter, java-test
- **personal** (default) — installs ts_ls, gopls, prettierd

LSPs are lazy-loaded by filetype regardless of profile. The env var only controls what gets installed.

### 4. Open Neovim

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
    editor.lua            gitsigns, which-key, mini.nvim, todo-comments, tokyonight
    telescope.lua         Fuzzy finder + LSP pickers
    lsp.lua               Mason + lspconfig (profile-aware)
    completion.lua        blink.cmp + LuaSnip
    treesitter.lua        Syntax highlighting + auto-install parsers
    format.lua            conform.nvim (prettier, jdtls)
    java.lua              nvim-jdtls plugin declaration
    debug.lua             nvim-dap + dap-ui
    explorer.lua          snacks.explorer (file tree)
    diffview.lua          Git diff viewer
    terminal.lua          toggleterm + Claude Code integration
    autopairs.lua         Auto-close brackets/quotes
    notes.lua             obsidian.nvim (Zettelkasten + Obsidian Sync)
ftplugin/
  java.lua                jdtls configuration (per-buffer)
```

## Key bindings

### General

| Key | Action |
|---|---|
| `<leader>sf` | Search files |
| `<leader>sg` | Search by grep |
| `<leader>sd` | Search diagnostics |
| `<leader><leader>` | Find buffers |
| `<leader>/` | Fuzzy search in current buffer |
| `<leader>e` | Toggle file explorer |
| `<leader>f` | Format buffer |
| `<C-\>` | Toggle floating terminal |
| `<leader>cc` | Open Claude Code |

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

### Java

| Key | Action |
|---|---|
| `<leader>co` | Organize imports |
| `<leader>cv` | Extract variable |
| `<leader>cc` | Extract constant |
| `<leader>cm` | Extract method (visual) |
| `<leader>ct` | Test class |
| `<leader>cn` | Test nearest method |

### Debug

| Key | Action |
|---|---|
| `<F5>` | Start/Continue |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>du` | Toggle debug UI |

### Git

| Key | Action |
|---|---|
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

## Linux

If using Linux, change `config_mac` to `config_linux` in `ftplugin/java.lua`.
