# vim: set filetype=sh :
# zmodload zsh/zprof # Performance Profiler

# =============================================================================
#                              Oh-My-Zsh Setup
# =============================================================================

if [ -f /etc/zshrc ]; then
    . /etc/zshrc
fi
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

source $ZSH/oh-my-zsh.sh # Power on the Oh-My-ZSH suite
export ZSH="/home/jrwrigh/.oh-my-zsh"

# Prevent setup `nice(5) failed: operation not permitted` issues
unsetopt BG_NICE

# =============================================================================
#                                   Plugins
# =============================================================================
# Check if zplug is installed

[ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

# zplug to update itself on `zplug --update`
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Fancy change directory plugin
zplug "b4b4r07/enhancd", use:init.sh

# zsh-syntax-highlighting must be loaded after executing compinit command
# and sourcing other plugins
zplug "zsh-users/zsh-completions" 
zplug "zsh-users/zsh-autosuggestions" 
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/extract",           from:oh-my-zsh
zplug "plugins/web-search",        from:oh-my-zsh


##### Theme through Zplug
# Make sure prompt is able to be generated properly.
setopt prompt_subst 
if [ $(cat $HOME/.computerID) = "CUBPortalVNC" ]; then
    zplug "caiogondim/bullet-train.zsh", use:bullet-train.zsh-theme, defer:2
else 
    zplug "caiogondim/bullet-train.zsh", use:bullet-train.zsh-theme, defer:3
fi
# load up all the zplug options and commands
zplug load

# =============================================================================
#                                   Aliases
# =============================================================================
alias la='ls -a'
alias ll='ls -lh'
alias lal='ls -alh'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'


# =============================================================================
#                                  Settings
# =============================================================================
export VISUAL='nvim'
export EDITOR="$VISUAL"

# # Set editor preference to nvim if available.
# if (( $+commands[nvim] )); then
# 	alias vim='() { $(whence -p nvim) $@ }'
# else
# 	alias vim='() { $(whence -p vim) $@ }'
# fi

eval `dircolors $HOME/gitRepos/dotfiles/dircolors.monokai`
# =============================================================================
#                                  Startup
# =============================================================================


# Performance Profiler
# zprof
