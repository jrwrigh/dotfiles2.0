#!/bin/bash

# ADD 2 DOTFiles (add2dotf)
# 
# ---
# Move file(s) to dotfiles repository, then add a sym link to the new location
# 

# .dotfile --> add2dotf.sh
# ==> $HomeDir/path/to/.dotfile --moved--> $DotfileDir/path/to/.dotfile
# ==> $DotfileDir/path/to/.dotfile --symlink--> $HomeDir/path/to/.dotfile
#
# ...where by default:
# HomeDir=$HOME
# CurrentDir=$(pwd -P)
# DotfileDir="$HomeDir/gitRepos/dotfiles2.0"

if [[ $SUDO_USER ]]; then
  echo "Running scripts you find on the internet as root is dangerous. Try again without 'sudo'."
  exit 1
fi

HomeDir=$HOME
CurrentDir=$(pwd -P)
DotfileDir=$HomeDir'/gitRepos/dotfiles2.0'

for filepath in $@
do
    echo WORKING ON $filepath .................
    filepath2home=$(realpath --relative-to=$HomeDir $filepath)
    filepath2homedir=$(dirname $filepath2home)
    mkdir -p $DotfileDir/$filepath2homedir
    newfilepath=$DotfileDir/$filepath2home
    oldfilepath=$HomeDir/$filepath2home
    echo $oldfilepath '--mv-->' $newfilepath
    echo $newfilepath '--symlink-->' $oldfilepath
    mv -f $oldfilepath $newfilepath && ln -s $newfilepath $oldfilepath
done
