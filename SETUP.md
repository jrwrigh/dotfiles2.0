# Steps to setup a new Linux computer

1. Clone `dotfiles` to `~/gitRepos`
2. Softlink `add2dotf` and `symlndotf` to `.local/bin`

## zsh

1. Install `oh-my-zsh`
2. Install `antibody` (either through AUR or command line)
3. Remove `oh-my-zsh`'s `.zshrc`
4. `symlndotf` the `.zshrc` file and `.config/zsh/zshPluginList`
5. Source `.zshrc` and run `antibody_bundle_loadfile`
6. Download starship to `.local/src/starship` (MUSL version if on remote
   system) and symlink to `.local/bin`
7. Source `.zshrc` again
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
2. Install vim-plug
3. `symlndotf` the whole `.config/nvim`
4. Start neovim
5. Run `:PlugInstall`

## fzf

1. Load git repository to `~/.local/src/fzf`
2. Install using `~/.local/src/fzf/install --xdg`
3. Symlink `.config/fzf/fzf.zsh`

## git

1. `symlndotf` `.config/git/gitconfig`
2. `git config --global include.path '~/.config/git/gitconfig'`

## ssh-agent systemd service

1. `symlndotf .config/systemd/user/ssh-agent.service`
2. `cd ~/.config/systemd/user`
3. `systemd --user enable ssh-agent`
4. `systemd --user start ssh-agent`

## odrive

1. Run command line from odrive sync agent webpage
2. symlink `odrive` from `$HOME/.odrive-agent`
3. Create/symlink `start_odrive` shell script
4. Follow online instructions for settings up authentication keys

## Miniconda

1. Run installer script (or get from AUR)
2. Symlink `.condarc`

## Zotero

1. Install via aur
2. Login and sync
3. Add ZotFile, zotero-shortdoi, zutilo, and zotero-better-bibtex
4. Setup quick copy as a Zotero context menu item (via Zutilo settings)

## VSCode

1. Install it
2. Install the settings-sync extension
3. Log into the settings sync extension and download settings
4. (Possibly?) Need to add TeXLive to path in `.profile` to make it behave

## Manjaro i3 GUI themes

1. Kvantum (Qt): KvOxygen
2. In `.config/gtk-3.0`, set `gtk-theme-name=Clearlooks`
3. Adjust masterpdfeditor4 to default look
4. Mouse pointer is "Aidwta" or "X11 Default Black" (as found on KDE or Gnome stores)
