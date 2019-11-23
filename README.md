# dotfiles 2.0

Need to update documentation. Notice the helper scripts `add2dotf.sh` and `symlndotf.sh`.

### Made a commit on a local computer branch, but it should also go in master:

First, find the commit hash that you want to move. Let's say it's `abcd123`.

```
git checkout master
git pull
git cherry-pick abcd123
git checkout [local computer branch]
git rebase master
```
If the transfer was successful, you can go back into `master` and push the result to the remote.

Note that when pushing the resulting branch to remote, this must be done with a `--force` because reasons.




### Update my local computer branch with latest master branch:

Probably a good idea to make a tag of the current status of the branch via `git tag [tagname,likeBACKUP]`.
This way if things go wrong you can simply (theoretically) do a `git reset --hard [tagname]` to undo.

This is possibly already done via a `ORIG_HEAD` tag when a rebase is performed, but I could be wrong.

```
git checkout master
git pull
git push
git checkout [local computer branch]
git rebase master
```

## Other Setup Notes

### git alias

If no other `[include]` is in the `~/.gitconfig`, then use:
`git config --global include.path '~/.config/gitconfig.aliases'`

Otherwise simply add `'~/.config/gitconfig.aliases'` to `~/.gitconfig`:

```
[include]
    path = {EXISTING PATH}
    path = ~/.config/gitconfig.aliases
```

Generally advised to put the includes at the beginning of the `.gitconfig` so
that directives in that file override the ones in the included file

