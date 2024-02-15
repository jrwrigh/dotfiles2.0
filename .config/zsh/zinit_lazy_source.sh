# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jrwrigh/.local/src/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/jrwrigh/.local/src/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/jrwrigh/.local/src/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/jrwrigh/.local/src/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/jrwrigh/.local/src/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/home/jrwrigh/.local/src/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# Spack initialization
source ~/.local/src/spack/share/spack/setup-env.sh
