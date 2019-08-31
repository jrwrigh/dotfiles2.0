# vim: set filetype=sh :
# Performance Profiler
# zmodload zsh/zprof
# NOTE: Current setup heavily based on dotfile from the GitHub repo: tonylambiris/dotfiles

# =============================================================================
#                              Oh-My-Zsh Setup
# =============================================================================
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
if [ $(cat $HOME/.computerID) = "DellBrick" ]; then
    export ZSH="/home/u2berggeist/.oh-my-zsh"
elif [ $(cat $HOME/.computerID) = "PalmettoClusterSSH" ]; then
    export ZSH="/home/jrwrigh/.oh-my-zsh"
    if [ -f /etc/zshrc ]; then
    	. /etc/zshrc
    fi
elif [ $(cat $HOME/.computerID) = "CUBManjaro" ]; then
    export ZSH="/home/jrwrigh/.oh-my-zsh"
elif [ $(cat $HOME/.computerID) = "YogaManjaro" ]; then
    export ZSH="/home/jrwrigh/.oh-my-zsh"
    export TERMINAL=xfce4-terminal
    TERMINAL=xfce4-terminal
elif [ $(cat $HOME/.computerID) = "CUBPortalVNC" ]; then
    export ZSH="/users/jrwrigh/.oh-my-zsh"
    export PATH=$HOME/bin:/usr/local/bin:$PATH
else
    echo "ERROR: no file '$HOME/.computerID' found."
    exit 1
fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="powerlevel9k/powerlevel9k"
# ZSH_THEME="agnoster"

# Power on the Oh-My-ZSH suite
source $ZSH/oh-my-zsh.sh

# Prevent setup `nice(5) failed: operation not permitted` issues
unsetopt BG_NICE

# =============================================================================
#                                   Plugins
# =============================================================================
# Check if zplug is installed

# [ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

# zplug to update itself on `zplug --update`
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Fancy detailed directory listing (ie. type `k` instead of `ls -l`)
zplug "supercrabtree/k"

# Fancy change directory plugin
zplug "b4b4r07/enhancd", use:init.sh

# zsh-syntax-highlighting must be loaded after executing compinit command
# and sourcing other plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3

zplug "plugins/common-aliases",    from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
# zplug "plugins/colorize",          from:oh-my-zsh
# zplug "plugins/command-not-found", from:oh-my-zsh
# zplug "plugins/copydir",           from:oh-my-zsh
# zplug "plugins/copyfile",          from:oh-my-zsh
# zplug "plugins/cp",                from:oh-my-zsh
zplug "plugins/dircycle",          from:oh-my-zsh
zplug "plugins/extract",           from:oh-my-zsh
zplug "plugins/history",           from:oh-my-zsh
zplug "plugins/tmux",              from:oh-my-zsh
# zplug "plugins/tmuxinator",        from:oh-my-zsh
# zplug "plugins/urltools",          from:oh-my-zsh
# zplug "plugins/vi-mode",           from:oh-my-zsh
# zplug "plugins/web-search",        from:oh-my-zsh

# Make ls colors not horrible for WSL
# Directory colors
if [ $(cat $HOME/.computerID) = "YogaManjaro" ]; then
    eval `dircolors $HOME/gitRepos/dotfiles/dircolors.monokai`
else
    zplug "seebi/dircolors-solarized", ignore:"*", as:plugin
fi

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
alias ll='ls -l'
alias lal='ls -al'


if [ $(cat $HOME/.computerID) = "PalmettoClusterSSH" ]; then
    alias ranger="python /home/jrwrigh/bin/ranger/ranger.py"
    alias qstatu="qstat -u $USER"
    alias lzg='lazygit'
elif [ $(cat $HOME/.computerID) = "DellBrick" ]; then
    alias lzg='lazygit'
elif [ $(cat $HOME/.computerID) = "CUBPortalVNC" ]; then
    alias nvim='~/bin/nvim.appimage'
fi

# Set editor preference to nvim if available.
if (( $+commands[nvim] )); then
	alias vim='() { $(whence -p nvim) $@ }'
else
	alias vim='() { $(whence -p vim) $@ }'
fi

# =============================================================================
#                                  Settings
# =============================================================================
export VISUAL='nvim'
export EDITOR="$VISUAL"

if [ $(cat $HOME/.computerID) = "PalmettoClusterSSH" ]; then
    export common="/common/miller/jrwrigh"
    PATH=/home/jrwrigh/local/bin:$PATH:$HOME/bin:/home/jrwrigh/bin/neovim/squashfs-root/usr/bin
    PATH=$PATH:/home/jrwrigh/.local/bin:/bin
    export PATH
    module load python/3.4
    export TERM="xterm-256color" # makes colors correct in MobaXterm tmux (replaces alias tmux="tmux -2"
fi

# To stop the security errors related to folder permissions in ~/.oh-my-zsh
# export ZSH_DISABLE_COMPFIX="true"

# =============================================================================
#                                  Startup
# =============================================================================

if zplug check "seebi/dircolors-solarized"; then
  which gdircolors &> /dev/null && alias dircolors='() { $(whence -p gdircolors) }'
  which dircolors &> /dev/null && \
	  eval $(dircolors $HOME/.zplug/repos/seebi/dircolors-solarized/dircolors.256dark)
fi


# Performance Profiler
# zprof
