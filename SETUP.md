# Steps to setup a new Linux computer

1. Clone `dotfiles` to `~/gitRepos`
2. Softlink `add2dotf` and `symlndotf` to `.local/bin`

## zsh

1. Symlink `.zshenv` to the home directory (to get the `ZSH_CONFIG_DIR` set)
2. `symlndotf .config/zsh` to get the zsh config files into the `ZSH_CONFIG_DIR`
3. Then relogin (or possibly just souce `.config/zsh/.zshrc`). zinit.zsh will auto install starship. zoxide, and the zsh plugins

## fzf

1. Load git repository to `~/.local/src/fzf`
2. Install using `~/.local/src/fzf/install --xdg`

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

## git

1. `symlndotf` `.config/git/gitconfig`
2. `git config --global include.path '~/.config/git/gitconfig'`

## Zoxide

Install currently handled by zinit

## ssh-agent systemd service

1. `symlndotf .config/systemd/user/ssh-agent.service`
2. `cd ~/.config/systemd/user`
3. `systemctl --user enable ssh-agent`
4. `systemctl --user start ssh-agent`
5. Prepend `AddKeysToAgent yes` to `~/.ssh/config` (assuming the option is
   valid for the version of `ssh` installed)

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

## PulseAudio
 - Simply use Manjaro's install script `install_pulse`

## Redshift
 - Enable redshift via it's systemd service. After installing from AUR,
 1. `systemctl  --user enable redshift-gtk`
 2. `systemctl  --user start redshift-gtk`

Note this means that systemd will restart Redshift if it is killed. You must
stop the systemd service to turn it off correctly.
