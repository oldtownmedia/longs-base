#!/bin/bash

echo "  "
echo "|-------------------------|"
echo "|     \033[1mWP Build Script\033[0m     |";
echo "|-------------------------|"
echo "  "

echo "\033[33mGit repo URL to write to:\033[0m"
read git_repo
export git_repo

echo "\033[33mNew theme path:\033[0m";
read theme_path
export theme_path

# Delete reference to submodules that now need to be included as repo files
git rm --cached content/mu-plugins
git rm --cached content/themes
echo "\033[91mdelete reference to submodule HEAD\033[0m"

rm -rf .gitmodules
mv .gitmodules-dev .gitmodules
echo "Replacing original gitmodules"

rm -rf content/mu-plugins/.git
rm -rf content/themes/skeleton/.git
echo "\033[91mDeleting git files in prior submodules\033[0m"

# Rename the theme folder
mv content/themes/skeleton content/themes/$theme_path
echo "\033[32mRenaming the theme folder to $theme_path";

# Remove old
git remote rm origin

# Re-add git to new repo
git remote add origin $git_repo
echo "\033[32mReplacing git origin with new path"

git add .
git commit -am "Initial Commit"
echo "\033[32mAdding all the new files to git for you for you"