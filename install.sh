#!/bin/bash

echo -e "\e[1mWP Build Script";

echo -e "\e[96mGit repo URL to write to:"
read git_repo
export git_repo

echo -e "\e[96mNew theme path:";
read theme_path
export theme_path

# Delete reference to submodules that now need to be included as repo files
git rm --cached content/mu-plugins
git rm --cached content/themes
echo -e "\e[91mdelete reference to submodule HEAD"

rm -rf .gitmodules
mv .gitmodules-dev .gitmodules
echo "Replacing original gitmodules"

rm -rf content/mu-plugins/.git
rm -rf content/themes/skeleton/.git
echo -e "\e[91mDeleting git files in prior submodules"

# Rename the theme folder
mv content/themes/skeleton content/themes/$theme_path
echo -e "\e[32mRenaming the theme folder to $theme_path";

# Remove old
git remote rm origin

# Re-add git to new repo
git remote add origin $git_repo
echo -e "\e[32mReplacing git origin with new path"

git add .
git commit -am "Initial Commit"
echo -e "\e[32mAdding all the new files to git for you for you"