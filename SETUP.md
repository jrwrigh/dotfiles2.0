# Steps to setup a new Linux computer

1. Clone `dotfiles` to `~/gitRepos`
2. Softlink `add2dotf` and `symlndotf` to `.local/bin`

## zsh

1. Install `oh-my-zsh`
2. Install `antibody`
3. Remove `oh-my-zsh`'s `.zshrc` 
5. `symlndotf` the `.zshrc` file and `.config/zsh/zshPluginList`
6. Source `.zshrc` and run `antibody_bundle_loadfile`
7. (Optional) Download starship (MUSL version) and place in `.local/bin`
8. Source `.zshrc` again
   - Everything should now be running normally

## ranger

1. Install `pip` if not already
2. Run `pip install --user ranger-fm`
3. If you get `curses module not found` error, try with Python `2.7`

## Neovim

1. Install `neovim`
   - Can be either through package manager or appimage from neovim website
   - Also install python neovim package
   - Place appimage/expanded appimage into .local/src/nvim 
3. Install vim-plug
4. `symlndotf` the whole `.config/nvim`
5. Start neovim
6. Run `:PlugInstall`

## git

1. `symlndotf` `.config/gitaliases`
2. `git config --global include.path '~/.config/gitconfig'`
