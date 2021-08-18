#!/usr/bin/env bash
## Run via `source .local/bin/startSSHAgent.sh` inside .zprofile

RS="\033[0m"    # reset
UL="\033[4m"    # underline

USAGE="
Start SSHAgent using a Unix Socket for authentication

${UL}Usage:${RS} startSSHAgent.sh [-h] [-f]

${UL}Options:${RS}

-h, --help      Show this help message

-f, --force     Delete the socket in \$SSH_AUTH_SOCK before starting
                    the agent

${UL}Description:${RS}

Start SSH Agent using a Unix Socket file located at \$SSH_AUTH_SOCK (if it is
set) or '\$XDG_RUNTIME_DIR/ssh-agent.socket'."

[ -n "${SSH_AUTH_SOCK+1}" ] || export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

OTHER_ARGUMENTS=()
for arg in "$@"
do
    case $arg in
        -h | --help)
            echo -e "$USAGE"
            exit 0
            ;;
        -f | --force)
            echo "Removing ${SSH_AUTH_SOCK}"
            [ -S "$SSH_AUTH_SOCK" ] && rm ${SSH_AUTH_SOCK}
            shift
            ;;
        *)
            OTHER_ARGUMENTS+=( "$1" )
            shift
            ;;
    esac
done

eval `ssh-agent -s -a $SSH_AUTH_SOCK`
