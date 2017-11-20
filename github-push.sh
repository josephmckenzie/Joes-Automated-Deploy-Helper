##!/bin/bash
##This script will push to GitHub and Heroku saving you time from having to manually push to both or to actually have to go to heroku to push you changed code each time.
#
## $ ./github-push.sh 'First Argument(Your commit message Put within quotes so you can put spaces ir else it will think every word seperated by spaces is a new agrument)' Second-Agrument(Ie: origin) Third-Agrument is your branch(Ie: master)
#
## **** An example of what it should look like when you run your script from the terminal ****
## $ ./github-push.sh 'Add your comment here' origin master
# Remember any branch can be used still it doesnt have to be master
##The -n defines the required character count to stop reading and -s hides the user's input, add "minus r" to the read flags, which will cause the string to be interpreted as raw without considering any backslash escapes
##read -n 1 -s -r -p "If your commit looks right, Press any key to continue"
## or you can use the following function so if you need to pause mutiple times in a script there is no need to rewrite it time and again, the -r -s -p can be added together if you wish as well as -n and 1 
#
#pause(){
# read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
#}
#
#### Old script using an if else statement doesnot loop until users says yes it looks right

## Adds the recently changed files to your commit
#git add .
##
### Displays the files you are commiting and Checks with user to make sure commit looks right.
#git status
##
#    echo -n "Does your commit look right? (y/n)"
#    read Useranswer
#    if [ $Useranswer = y ]; then
#       #Commits the files to be pushed to Github
#       git commit -m "$1"
#       
#							#Pushes the files in your commit to github
#       git push $2 $3 
#							
#    elif [ $Useranswer = n ]; then
#        echo -n 'Please enter the name of the file you wish to remove: '
#								read file
#        git reset HEAD $file
#								echo -n "Does your commit look right? (y/n)"
#        read Useranswer
#        
#    fi
####

#!/bin/env bash
# adds all the changed files to the commit
git add .
## Displays the files you are commiting to show user the commit and make sure it looks right and all files should be committed.
git status
#asks the user if the commit looks right and until Y or y is entered it will not push the commit but as you to enter the file you wish to remove from the commit
 echo -n "Does your commit look right, If so press any key to continue or press N/n to choose a file to remove from the commit: "
	#read is the same thing basically as gets in ruby Ie: ask for user input and stores the answer to be used in the variable name 
read Useranswer
while [ $Useranswer == n ] || [ $Useranswer == N ] ;
do
  echo -n 'Please enter the name of the file you wish to remove or press CTRL+C to cancel :'
  read file
  git reset HEAD $file
		git status
  echo -n "Does your commit look right, If so press any key to continue or press N/n to choose a file to remove from the commit: "
  read Useranswer
done
#Having said yes the commit looks correct it will push
#Commits the files to be pushed to Github
git commit -m "$1"    
#Pushes the files in your commit to github to the origin/branch specified whe launching the script through 
git push $2 $3 

