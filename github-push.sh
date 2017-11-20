#!/bin/bash
#This script will push to GitHub and Heroku saving you time from having to manually push to both or to actually have to go to heroku to push you changed code each time.

# $ ./github-push.sh 'First Argument(Your commit message Put within quotes so you can put spaces ir else it will think every word seperated by spaces is a new agrument)' Second-Agrument(Ie: origin) Third-Agrument is your branch(Ie: master)

# An example of what it should look like when you run your script from the terminal
# $ ./github-push.sh 'Add your comment here' origin master

#The -n defines the required character count to stop reading and -s hides the user's input, add "minus r" to the read flags, which will cause the string to be interpreted as raw without considering any backslash escapes
#read -n 1 -s -r -p "If your commit looks right, Press any key to continue"
# or you can use the following function so if you need to pause mutiple times in a script there is no need to rewrite it time and again, the -r -s -p can be added together if you wish as well as -n and 1 

pause(){
 read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
}

# Adds the recently changed files to your commit
git add .

# Displays the files you are commiting and Checks with user to make sure commit looks right.
git status

# Asks user to confirm that the commit looks right and if it does push any key to push it to the branch that the suppiled in the command line when running the script

pause

#Commits the files to be pushed to Github
git commit -m "$1"

#Pushes the files in your commit to github
git push $2 $3