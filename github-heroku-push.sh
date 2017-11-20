#!/bin/bash
#This script will push to GitHub and Heroku saving you time from having to manually push to both or to actually have to go to heroku to push you changed code each time.


# Adds the recently changed files to your commit
git add .

# Displays the files you are commiting and Checks with user to make sure commit looks right.
git status

# Asks user to confirm that the commit looks right and if it does push any key to push it to the branch that the suppiled in the command line when running the script
read -n 78 -r -p "If your commit looks right, Press any key to continue"

#Commits the files to be pushed to Github
git commit -m "$1"
#Pushes the files in your commit to github
git push $2 $3
#This will push to heroku * Note this pushes to the master branch of heroku , if you have mutiple branches you are working on and they are named the same as the branch you are pushing to on GitHub you can change "master" on the following line to $3 which will push to the branch you specified. it should be noted that if you are on the correct branch when you push in your terminal there is no need to worry as it will push that branch anyways and there is really no need to specify origin master but some people like to make sure so lets just go ahead and add specify it just to make sure all is gravy 

git push heroku master 
