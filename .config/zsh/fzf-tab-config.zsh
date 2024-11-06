#!/usr/bin/env zsh

zstyle ':fzf-tab:*' fzf-bindings 'bspace:backward-delete-char/eof'
zstyle ':fzf-tab:*' continuous-trigger '/'

# Don't sort git checkout branches (I think sorts by most recent branch)
zstyle ':completion:*:git-checkout:*' sort false

# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

# Use ls colors for completion coloring
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# Show preview of directory contents
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -lt --color=always $realpath'

# Show preview of zoxide directory contents
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls -lt --color=always $realpath'

# Show systemd service statuses when tabbing
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# Preview environment variable definition
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	fzf-preview 'echo ${(P)word}'
