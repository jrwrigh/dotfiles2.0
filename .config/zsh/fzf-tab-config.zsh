#!/usr/bin/env zsh

zstyle ':fzf-tab:*' fzf-bindings 'bspace:backward-delete-char/eof'
zstyle ':fzf-tab:*' continuous-trigger '/'

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:*' switch-group ',' '.'
