#!/bin/bash

echo "  "
echo "|-------------------------|"
echo "|     \033[1mWP Build Script\033[0m     |";
echo "|-------------------------|"
echo "  "

# Get our necessary variables
read -e -p "? Git repo URL to write to:* " git_repo
export git_repo

read -e -p "? New theme path:* " theme_path
export theme_path

read -e -p "? Site URL:* " site_url
export site_url

# DB Variables
read -e -p "? MySQL Host: [localhost] " mysqlhost
[ -z "${mysqlhost}" ] && mysqlhost='localhost'
export mysqlhost

read -e -p "? MySQL DB Name:* " mysqldb
export mysqldb

read -e -p "? MySQL DB User: [root] " mysqluser
[ -z "${mysqluser}" ] && mysqluser='root'
export mysqluser

read -e -p "? MySQL Password:* " mysqlpass
[ -z "${mysqlpass}" ] && mysqlpass='root'
export mysqlpass

# Update submodules to the latest so we know what we're working with
cd content/mu-plugins
git pull origin master
cd assets/metabox
git pull origin master
cd ../../../themes/skeleton
git pull origin master
cd ../../../
echo "\033[32m+ Updating submodules\033[0m";

# Delete reference to submodules that now need to be included as repo files
git rm --cached content/mu-plugins
git rm --cached content/mu-plugins/assets/metabox
rm content/mu-plugins/assets/metabox/.git
rm content/mu-plugins/.gitmodules
git rm --cached content/themes/skeleton
echo "\033[91- mdelete reference to submodule HEAD\033[0m"

rm .gitmodules

rm -rf content/mu-plugins/.git
rm -rf content/themes/skeleton/.git
rm -rf wordpress/.gi
echo "\033[91m- Deleting git files in prior submodules\033[0m"

# Create the databse
mysql -u $mysqluser -h $mysqlhost -p$mysqlpass -Bse "CREATE DATABASE $mysqldb;"

# Grab our Salt Keys
wget -O /tmp/wp.keys https://api.wordpress.org/secret-key/1.1/salt/

# Re-salt with the new keys
sed -i.tmp '/#@-/r /tmp/wp.keys' wp-config.php
sed -i.tmp "/#@+/,/#@-/d" wp-config.php
echo "\033[32m+ Resalting wp-config.php\033[0m";

# Replace DB variables
sed -i.tmp "s/msql_host/"$mysqlhost"/" wp-config-local.php
sed -i.tmp "s/msql_dbname/"$mysqldb"/" wp-config-local.php
sed -i.tmp "s/msql_user/"$mysqluser"/" wp-config-local.php
sed -i.tmp "s/msql_password/"$mysqlpass"/" wp-config-local.php

# Rename the theme folder
rm content/themes/skeleton/README.md
mv content/themes/skeleton content/themes/$theme_path
echo "\033[32m| Renaming the theme folder to $theme_path\033[0m";

# Move /content into /wordpress
mv -f content wordpress
rm -rf wordpress/wp-content
mv wordpress/content wordpress/wp-content

# Move /wordpress contents into root & clean up
cd wordpress
mv * ../
cd ../
rm -rf wordpress

# Swap out our original gitignore file for the development one
rm .gitignore
mv .gitignore-dev .gitignore

# Remove any DS_Store files that might have snuck in
git rm -f *.DS_Store

# Remove old git origin
git remote rm origin

# Re-assign to new git repo
git remote add origin $git_repo
echo "\033[32m+ Replacing git origin with new path\033[0m"

# Set proper permissions
chmod 755 wp-content

# Clean Up
rm /tmp/wp.keys
rm README.md
rm wp-config.php.tmp
rm wp-config-local.php.tmp

# Handle new git situation
git add .
git commit -am "Initial Commit"
echo "\033[32m+ Adding all the new files to git for you for you\033[0m"

echo "\033[32m***************\033[0m";
echo "\033[32m** All done! **\033[0m";
echo "\033[32m***************\033[0m";
