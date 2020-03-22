# vim: set filetype=sh :
# zmodload zsh/zprof # Performance Profiler

# =============================================================================
#                              Initialization
# =============================================================================

if [ -f /etc/zshrc ]; then
    . /etc/zshrc
fi
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

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

# =============================================================================
#                                  Settings
# =============================================================================
export VISUAL='nvim'
export EDITOR="$VISUAL"
export MYDOTFILES="${HOME}/gitRepos/dotfiles2.0"


eval $(dircolors ${MYDOTFILES}/dircolors.monokai)

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


# Performance Profiler
# zprof
