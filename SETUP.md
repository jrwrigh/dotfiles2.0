# Steps to setup a new linux computer

1. Clone `dotfiles` to `~/gitRepos`

## Neovim

1. Install `neovim`
   - Can be either through package manager or appimage from neovim website
   - Also install python neovim package
2. Add `computer.vim` and `.computerID` files
   - `computer.vim` is placed in `~/.config/nvim/`
   ```vim
   let computer="[COMPUTERNAME]"
   ```
   - `.computerID` is placed in home directory, contains just the [COMPUTERNAME]
3. Install vim-plug
4. Soft link `~/gitRepos/dotfiles/nvim` to `~/.config/nvim`
5. Start neovim
6. Run `:PlugInstall`

## zsh

1. Install `oh-my-zsh`
2. Install `zplug`
3. Remove `oh-my-zsh`'s `.zshrc` 
4. Add new [COMPUTERNAME] to `dot.zshrc`
   - Ie. Add another if statement similar to that already written that reflects 
   the new locations of things
5. Softlink the custom one from dotfiles to the home directory
6. Source the new `.zshrc`
7. Run `zplug install`
8. Source `.zshrc` again
   - Everything should now be running normally
