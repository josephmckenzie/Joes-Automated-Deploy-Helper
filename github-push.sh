#!/bin/bash

# Adds the recently changed files to your commit
git add .
# Checks with user to make sure commit looks right
git status
# Asks user to confirm that the commit looks right and if it does push any key to push it to the branch that the suppiled in the command line when running the script
read -n 1 -s -r -p "If your commit looks right, Press any key to continue"
#Commits the files to be pushed to Github
git commit -m "$1"
#Pushes the files in your commit to github
git push $2 $3
