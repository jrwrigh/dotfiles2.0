## Run via `source .local/bin/startSSHAgent.sh` inside .zprofile

[ -n "${SSH_AUTH_SOCK+1}" ] || export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

eval `ssh-agent -s -a $SSH_AUTH_SOCK`
