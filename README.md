Note that all files must have a link to them from their correct locations.

On Linux, this is done by:

```bash
ln -s [ACTUALFILE] [DESTINATION]
```
# `.bashrc`

## ranger-cd command:
Copy this to the end of `.bashrc`:
```bash
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}
```
## git-completion

Copy this to the end of `.bashrc` for git completions:

```bash
source ~/gitRepos/dotfiles/git_completion.bash
```

# tmux

## Installing tmux on cluster
Use the script in `./tmux/tmux_local_install.sh`. Based from git gist: https://gist.github.com/elfosardo/b23058f9d609fcb0878fc42f5b6c935d
Note: the script in this repo is not the script in the gist itself. It is the script posted in the comments on Jun 30, 2018.

## Install tmux Plugin Manager
Go to https://github.com/tmux-plugins/tpm for instructions

## 256 Color setting
An alias must be put in `.bashrc` to force tmux to use 256 bit colors:

```bash
alias tmux="tmux -2"
```

# Terminator

## Color Theme
Follow instructions from [terminator](https://github.com/EliverLara/terminator-themes).
Requires `requests` package for python 2.7+
Preferred color combo is `Monokai Soda`

# Neovim

## Color Theme
Use `wget` to transfer the contents of the following link into `~/.config/nvim/colors`:
https://raw.githubusercontent.com/crusoexia/vim-monokai/master/colors/monokai.vim

## Neovim Plugins
Install `vim-plug` into `~/.local/share/nvim/plugged`
Then run `:PlugInstall` inside neovim to download and install the plugins

### Airline Powerline Fonts
To get the arrows part of airline working correctly, you need to use install powerline fonts. Refer to the wiki of vim-airline to figure it out.

### YouCompleteMe Setup
Run the `:PlugInstall` per usual, then go to `~/.local/share/nvim/plugged/YouCompleteMe` and run `install.py` in there. It requires `cmake`, so that may need to be installed via `sudo apt install cmake`
