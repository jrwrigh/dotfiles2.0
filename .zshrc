# vim: set filetype=sh :
# zmodload zsh/zprof # Performance Profiler

# =============================================================================
#                              Initialization
# =============================================================================

if [ -f /etc/zshrc ]; then
    . /etc/zshrc
fi
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# From https://stackoverflow.com/a/38980986/7564988 on using systemd to manage
# ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# =============================================================================
#                              Oh-My-Zsh Setup
# =============================================================================

export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh # Power on the Oh-My-ZSH suite

# Prevent setup `nice(5) failed: operation not permitted` issues
unsetopt BG_NICE

# =============================================================================
#                                   Plugins
# =============================================================================

# Plugins are listed in ~/.config/zsh/zshPluginList
ANTIBODY_PLUGIN_LOAD_PATH=~/.config/zsh/.antibody_plugin_load.sh

antibody_bundle_loadfile() {
        # Create plugin load file
    antibody bundle < ~/.config/zsh/zshPluginList > $ANTIBODY_PLUGIN_LOAD_PATH
    source $ANTIBODY_PLUGIN_LOAD_PATH
}

# The load file is then sourced
[ -f $ANTIBODY_PLUGIN_LOAD_PATH ] && source $ANTIBODY_PLUGIN_LOAD_PATH

eval "$(starship init zsh)"

# =============================================================================
#                                   fzf Setup
# =============================================================================

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && \
    source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/fzf-tab-config.zsh ] && \
    source "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/fzf-tab-config.zsh

# =============================================================================
#                                  Settings
# =============================================================================
export VISUAL='nvim'
export EDITOR="$VISUAL"
export MYDOTFILES="${HOME}/gitRepos/dotfiles2.0"


eval $(dircolors ${MYDOTFILES}/dircolors.monokai)

zstyle ':completion:*:ssh:*' hosts on
zstyle ':completion:*:scp:*' hosts on

# =============================================================================
#                                   Aliases
# =============================================================================

[ -f "$HOME/.config/aliasrc" ] && source $HOME/.config/aliasrc

# =============================================================================
#                                 Functions
# =============================================================================

# Use Ctrl-z to reopen background process, equiv of OMZ/fancy-ctrl-z
# From: https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
fancy-ctrl-z () {
    if [[ $#BUFFER -eq 0 ]]; then
        BUFFER="fg"
        zle accept-line
    else
        zle push-input
        zle clear-screen
    fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# =============================================================================
#                                  Startup
# =============================================================================

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jrwrigh/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/jrwrigh/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/jrwrigh/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/jrwrigh/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Performance Profiler
# zprof
