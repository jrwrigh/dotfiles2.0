# vim: set filetype=sh :
# zmodload zsh/zprof # Performance Profiler

# =============================================================================
#                              Initialization
# =============================================================================

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# =============================================================================
#                                 Functions
# =============================================================================

[ -f "$ZSH_CONFIG_DIR/functions.zsh" ] && source $ZSH_CONFIG_DIR/functions.zsh

# =============================================================================
#                                  Settings
# =============================================================================

[ -f "$ZSH_CONFIG_DIR/settings.zsh" ] && source $ZSH_CONFIG_DIR/settings.zsh
[ -f "$ZSH_CONFIG_DIR/colorsetup.zsh" ] && source $ZSH_CONFIG_DIR/colorsetup.zsh

# =============================================================================
#                                 Completion
# =============================================================================

autoload -U compinit; compinit

[ -f "$ZSH_CONFIG_DIR/completion.zsh" ] && source $ZSH_CONFIG_DIR/completion.zsh

# =============================================================================
#                                 Key Bindings
# =============================================================================

[ -f "$ZSH_CONFIG_DIR/key-bindings.zsh" ] && source $ZSH_CONFIG_DIR/key-bindings.zsh

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

compinit

eval "$(starship init zsh)"

# =============================================================================
#                                   fzf Setup
# =============================================================================

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && \
    source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/fzf-tab-config.zsh ] && \
    source "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/fzf-tab-config.zsh

# =============================================================================
#                                   Aliases
# =============================================================================

[ -f "$HOME/.config/aliasrc" ] && source $HOME/.config/aliasrc
[ -f "$ZSH_CONFIG_DIR/aliases.zsh" ] && source $ZSH_CONFIG_DIR/aliases.zsh

# =============================================================================
#                                  Startup
# =============================================================================


# Performance Profiler
# zprof
