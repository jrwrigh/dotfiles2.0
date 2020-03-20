#!/bin/bash
# ---
# SYMLiNk DOTFiles (symlndotf)
# 
# This script will create symlinks of the specified file in the same relative location while backing up.

# $DotfileDir/path/to/new_dotfile --> symlndotf.sh
# ==> $HomeDir/path/to/old_dotfile --moved--> $BackupDir/path/to/old_dotfile_timestamp
# ==> $HomeDir/path/to/new_dotfile --symlink--> $DotfileDir/path/to/new_dotfile
#
# ...where by default:
# HomeDir=$HOME
# BackupDir="$HomeDir/.dotfiles.backups"
# CurrentDir=$(pwd -P)
# DotfileDir="$HomeDir/gitRepos/dotfiles2.0"

set -e # Stop script on any error

if [[ $SUDO_USER ]]; then
  echo "Running scripts you find on the internet as root is dangerous. Try again without 'sudo'."
  exit 1
fi

HomeDir=$HOME
BackupDir="$HomeDir/.dotfiles.backups"
CurrentDir=$(pwd -P)
DotfileDir="$HomeDir/gitRepos/dotfiles2.0"

backup_dotfile() {
    if [[ ! -e $BackupDir ]]; then
      echo "Creating backups folder $BackupDir..."
      mkdir $BackupDir
    fi

    filepath=$(realpath --relative-to=$DotfileDir $1)
    filedirpath=$(dirname $filepath)
    if [[ -e "$HomeDir/$filepath" ]]; then
        echo "    $filepath already exists. Backing up to $BackupDir"
        mkdir -p $BackupDir/$filedirpath
        datesuffix=$(date '+%Y%m%d%H%M%S')
            # Copy the file while removing symlinks if present
        cp -L $HomeDir/$filepath $BackupDir/${filepath}_$datesuffix && rm $HomeDir/$filepath
        echo "    $(basename filepath) backed up to $BackupDir/${filepath}_$datesuffix"
    fi
}

symlink_dotfile() {
    filepath=$(realpath --relative-to=$DotfileDir $1)
    filedirpath=$(dirname $filepath)
    filename=$(basename $filepath)

    mkdir -p $HomeDir/$filedirpath && ln -s $DotfileDir/$filepath $HomeDir/$filepath
}

for dotfilepath in $@;
do
    echo WORKING ON $dotfilepath '............'
    backup_dotfile $dotfilepath
    symlink_dotfile $dotfilepath
done

