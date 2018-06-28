Note that all files must have a link to them from their correct locations.

On Linux, this is done by:

```bash
ln -s [ACTUALFILE] [DESTINATION]
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
