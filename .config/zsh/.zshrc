# vim: set filetype=sh :
# zmodload zsh/zprof # Performance Profiler

# =============================================================================
#                              Initialization
# =============================================================================

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config}"/ripgrep.config

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

autoload -Uz compinit; compinit

[ -f "$ZSH_CONFIG_DIR/completion.zsh" ] && source $ZSH_CONFIG_DIR/completion.zsh

# =============================================================================
#                                 Key Bindings
# =============================================================================

[ -f "$ZSH_CONFIG_DIR/key-bindings.zsh" ] && source $ZSH_CONFIG_DIR/key-bindings.zsh

# =============================================================================
#                                   Plugins
# =============================================================================

export ZINIT_NO_ALIASES # turn off zinit aliases
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice wait lucid
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit ice wait lucid
zinit snippet OMZ::plugins/extract/extract.plugin.zsh
zinit ice wait lucid
zinit snippet OMZ::plugins/tmux/tmux.plugin.zsh
zinit ice wait lucid atclone"git checkout 02ce77c" atpull"%atclone"  # See https://github.com/Aloxaf/fzf-tab/issues/481
zinit light Aloxaf/fzf-tab

zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

zinit ice blockf wait lucid
zinit light zsh-users/zsh-completions

zinit ice as"completion"
zinit snippet https://github.com/conda-incubator/conda-zsh-completion/blob/master/_conda

zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit load starship/starship

zinit ice as"command" from"gh-r" lucid
zinit light ajeetdsouza/zoxide
eval "$(zoxide init --cmd cd zsh)"

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jrwrigh/.local/src/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/jrwrigh/.local/src/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/jrwrigh/.local/src/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/jrwrigh/.local/src/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Performance Profiler
# zprof
