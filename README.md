# dotfiles 2.0

Need to update documentation. Notice the helper scripts `add2dotf.sh` and `symlndotf.sh`.

There are a few "master-esque" branches. The first is obviously `master`. This
holds common items for the other two "master-esque" branches. The other two are
`desktop` and `server`. `desktop` is all configurations related to computers
that I use the desktop on and have more liberal control over. `server` is for
configurations on machines I don't have control over and generally only access
via ssh. The primary goal of this is to have `server` contain as minimal a
dependency list as possible.

## Made a commit on a local computer branch, but it should also go in master

First, find the commit hash that you want to move. Let's say it's `abcd123`.

```sh
git checkout master
git pull
git cherry-pick abcd123
git checkout [local computer branch]
git rebase master
```

If the transfer was successful, you can go back into `master` and push the
result to the remote.

Note that when pushing the resulting branch to remote, this must be done with a
`--force` because this is changing the history. **`master` cannot be force pushed**

### Update my local computer branch with latest master branch

If something goes wrong, simply `git reset --hard ORIG_HEAD` will get you back
to the branches original state.

```sh
git checkout master
git pull
git push
git checkout [local computer branch]
git rebase master
```

## Other Setup Notes

See `SETUP.md` for more detailed notes on setting up a system.

### git alias

If no other `[include]` is in the `~/.gitconfig`, then use:
`git config --global include.path '~/.config/gitconfig.aliases'`

Otherwise simply add `'~/.config/gitconfig.aliases'` to `~/.gitconfig`:

```gitconfig
[include]
    path = {EXISTING PATH}
    path = ~/.config/gitconfig.aliases
```

Generally advised to put the includes at the beginning of the `.gitconfig` so
that directives in that the local file overrides these "default" settings.

## List of common packages I use (and should remember)

| Utility Type | Program Name |
|--------------|--------------|
| Screen Shots | Spectacle, flameshot  |
| GIF Screen Recorder | peek  |
| PDF          | Master PDF Editor 4 |
| GUI File Manager | pcmanfm  |
| VNC Client   | tigervnc     |
| G600 Mouse driver | piper |
| Emoji Font for Web | noto-fonts-emoji |
