# Setup fzf
# ---------
if [[ ! "$PATH" == */home/jrwrigh/.local/src/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${HOME}/.local/src/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${HOME}/.local/src/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${HOME}/.local/src/fzf/shell/key-bindings.zsh"
