setopt auto_cd            # interpret command line as cd if valid path
setopt auto_pushd         # push changed directories to directory stack
setopt pushd_ignore_dups
setopt pushdminus

setopt multios            # auomatically adds tee and cat when multiple redirections are attempted
# setopt prompt_subst

autoload -Uz is-at-least

## jobs
setopt long_list_jobs

env_default 'PAGER' 'less'
env_default 'LESS' '-R'

# recognize comments
setopt interactivecomments   # allow '#' comments in interactive shell session


## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data


