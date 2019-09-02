#!/bin/bash
# ---
# Create symlinks for dotfile
# 
# This script will create symlinks of the specified file in the same relative location while backing up.

# $CurrentDir/path/to/new_dotfile --> symlink_dotfile.sh
# ==> $HomeDir/path/to/old_dotfile --moved--> $BackupDir/path/to/old_dotfile_timestamp
# ==> $HomeDir/path/to/new_dotfile --symlink--> $CurrentDir/path/to/new_dotfile
#
# ...where by default:
# HomeDir=$HOME
# BackupDir="$HomeDir/.dotfiles.backups"
# CurrentDir=$(pwd -P)
# DotfileDir=$CurrentDir
#
# Note: $CurrentDir should be the actual base directory for the dotfiles git. 

# In other words, THIS SHOULD BE RUN AT THE DOTFILES GIT DIRECTORY LEVEL!!



if [[ $SUDO_USER ]]; then
  echo "Running scripts you find on the internet as root is dangerous. Try again without 'sudo'."
  exit 1
fi

HomeDir=$HOME
BackupDir="$HomeDir/.dotfiles.backups"
CurrentDir=$(pwd -P)
DotfileDir=$CurrentDir

symlink_dotfile() {
    filepath=$1
    filedirpath=$(dirname $filepath)
    filename=$(basename $filepath)

    mkdir -p $HomeDir/$filedirpath && ln -s $CurrentDir/$filepath $HomeDir/$filepath
}

backup_dotfile() {
    if [[ ! -e $BackupDir ]]; then
      echo "Creating backups folder $BackupDir..."
      mkdir $BackupDir
    fi

    filepath=$1
    filedirpath=$(dirname $filepath)
    if [[ -e "$HomeDir/$filepath" ]]; then
        echo "$filepath already exists. Backing up to $BackupDir"
        mkdir -p $BackupDir/$filedirpath
        datesuffix=$(date '+%Y%m%d%H%M%S')
            # Copy the file while removing symlinks if present
        cp -L $HomeDir/$filepath $BackupDir/${filepath}_$datesuffix && rm $HomeDir/$filepath
        echo "$(basename filepath) backed up to $BackupDir/${filepath}_$datesuffix"
    fi
}

backup_dotfile $1
symlink_dotfile $1

