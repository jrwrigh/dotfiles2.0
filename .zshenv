export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

(( ! ${+XDG_RUNTIME_DIR} )) && export XDG_RUNTIME_DIR="$HOME/.local/run"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_CONFIG_DIR="$XDG_CONFIG_HOME/zsh"

export EDITOR="nvim"
export VISUAL="nvim"

export HISTFILE="$ZSH_CONFIG_DIR/zsh_history"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

export MYDOTFILES="${HOME}/gitRepos/dotfiles2.0"
