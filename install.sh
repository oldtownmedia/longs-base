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

echo "\033[33mSite URL:\033[0m"
read site_url
export site_url

# Delete reference to submodules that now need to be included as repo files
git rm --cached content/mu-plugins
git rm --cached content/themes
echo "\033[91- mdelete reference to submodule HEAD\033[0m"

rm -rf .gitmodules
mv .gitmodules-dev .gitmodules
echo "+ Replacing original gitmodules"

rm -rf content/mu-plugins/.git
rm -rf content/themes/skeleton/.git
echo "\033[91m- Deleting git files in prior submodules\033[0m"

# Grab our Salt Keys
wget -O /tmp/wp.keys https://api.wordpress.org/secret-key/1.1/salt/

# Re-salt with the new keys
sed -i.tmp '/#@-/r /tmp/wp.keys' wp-config.php
sed -i.tmp "/#@+/,/#@-/d" wp-config.php
echo "\033[32m+ Resalting wp-config.php\033[0m";

# Replace site URL with new
sed -i.tmp "s,LOCALURL,"$site_url",g" wp-config-local.php

# Rename the theme folder
mv content/themes/skeleton content/themes/$theme_path
echo "\033[32m| Renaming the theme folder to $theme_path\033[0m";

# Remove old git origin
git remote rm origin

# Re-assign to new git repo
git remote add origin $git_repo
echo "\033[32m+ Replacing git origin with new path\033[0m"

# Handle new git situation
git add .
git commit -am "Initial Commit"
echo "\033[32m+ Adding all the new files to git for you for you\033[0m"

# Clean Up
rm /tmp/wp.keys
rm /wp-config.php.tmp
rm /wp-config-local.php.tmp

echo "\033[32m** All done! **\033[0m";