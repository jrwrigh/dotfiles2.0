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

# Plugins are listed in ~/.config/zshPluginList
ANTIBODY_PLUGIN_LOAD_PATH=~/.config/zsh/.antibody_plugin_load.sh

antibody_bundle_loadfile() {
        # Create plugin load file
	antibody bundle < ~/.config/zsh/zshPluginList > $ANTIBODY_PLUGIN_LOAD_PATH
    source $ANTIBODY_PLUGIN_LOAD_PATH
}

# The load file is then sourced
[ -f $ANTIBODY_PLUGIN_LOAD_PATH ] && source $ANTIBODY_PLUGIN_LOAD_PATH

# =============================================================================
#                                   Aliases
# =============================================================================

[ -f "$HOME/.config/aliasrc" ] && source $HOME/.config/aliasrc

# =============================================================================
#                                  Settings
# =============================================================================
export VISUAL='nvim'
export EDITOR="$VISUAL"


eval `dircolors $HOME/gitRepos/dotfiles2.0/dircolors.monokai`
# =============================================================================
#                                  Startup
# =============================================================================


# Performance Profiler
# zprof
