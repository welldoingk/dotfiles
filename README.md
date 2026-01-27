# Dotfiles

Personal dotfiles configuration.

## Contents

- `.tmux.conf` - tmux configuration with Catppuccin theme

## tmux Setup

### Features

- Dual prefix: `Ctrl-b` and `Ctrl-a`
- Mouse support enabled
- Vi-style copy mode
- Vim-style pane navigation (`h/j/k/l`)
- Catppuccin-inspired color scheme
- TPM (Tmux Plugin Manager) with plugins:
  - tmux-sensible
  - tmux-prefix-highlight

### Key Bindings

| Key | Action |
|-----|--------|
| `prefix + \|` | Split pane horizontally |
| `prefix + -` | Split pane vertically |
| `prefix + h/j/k/l` | Navigate panes (vim-style) |
| `prefix + H/J/K/L` | Resize panes |
| `Alt + Arrow` | Navigate panes (no prefix) |
| `prefix + r` | Reload config |

### Installation

```bash
# Clone the repository
git clone https://github.com/welldoingk/dotfiles.git ~/dotfiles

# Symlink tmux config
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# Install TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install plugins (in tmux)
# Press: prefix + I
```

## License

MIT
