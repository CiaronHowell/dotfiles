# .dotfiles

Nice-looking and **blazingly fast** terminal in seconds, *or your money back*.

Managed with [yadm](https://yadm.io), so the files live exactly where they belong in `$HOME` — no symlink farm required.

## Installation

1. Install [yadm](https://yadm.io/docs/install) — a thin wrapper around `git`, so every `git` command works exactly how you'd expect
2. Clone the repo:

   ```sh
   yadm clone <repo_url>
   ```

3. The [bootstrap script](../.config/yadm/bootstrap) should run automatically after cloning. If it doesn't, kick it off with:

   ```sh
   yadm bootstrap
   ```

   On macOS this installs Homebrew (if missing) and everything in the [Brewfile](../.Brewfile) via `brew bundle --global`

4. Restart your shell

## Contents

| Area | Config | Notes |
| --- | --- | --- |
| Editor | [Neovim](../.config/nvim/) | Lua config built on [lazy.nvim](https://github.com/folke/lazy.nvim) — LSP via mason/lspconfig, treesitter, telescope, harpoon, gitsigns, fugitive and more |
| Shell | [`.zshrc`](../.zshrc), [`.zimrc`](../.zimrc) | Zsh with the [Zim](https://zimfw.sh) framework — autosuggestions, syntax highlighting, history substring search |
| Prompt | [starship.toml](../.config/starship.toml) | [Starship](https://starship.rs) prompt, initialised via Zim's starship module |
| Multiplexer | [`.tmux.conf`](../.tmux.conf) | Plays nicely with Neovim via vim-tmux-navigator |
| Window management | [AeroSpace](../.config/aerospace/aerospace.toml) | Tiling window manager for macOS |
| Packages | [`.Brewfile`](../.Brewfile) | CLI tools and casks installed by bootstrap |

## Machine-specific configs

Work-only settings are handled with [yadm alternate files](https://yadm.io/docs/alternates) — e.g. [`.gitconfig##class.Work`](../.config/yadm/alt/) is only linked into place on machines with:

```sh
yadm config local.class Work
```
