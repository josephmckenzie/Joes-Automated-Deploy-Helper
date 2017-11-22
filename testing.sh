##!/bin/env bash
 echo  "Where would you like to push/commit code to today? :"
				echo -e "1. Github"
				echo -e "2. Heroku"
				echo -e "3. Amazon"
				echo -n "Enter a number: "
    read MainService 
    if [ "$MainService" = 1 ]; then
      echo "What would you like to do today?"
						echo -e "1. Pull"
						echo -e "2. Push"
						echo -n "Enter a number: "
						read Github
				if [ "$Github" = 1 ]; then
				git pull origin master
				elif [ "$Github" = 2 ]; then
git add .
git status
commitcheck="n"
while [ "$commitcheck" == n ]; do
    echo -n " Does this look good? (y/n): "
    read ANSWER
    commitcheck=`echo $ANSWER | tr [:upper:] [:lower:] | cut -c 1`
    if [ "$commitcheck" == n ]; then
        echo -e "Enter file to remove:"
								read file
								git reset HEAD $file
								git status
					else 
					echo -e "Please enter a commit message: "
				read commitmessage
				git commit -m "$commitmessage"
					echo -e "Enter the branch you want to push to: "
					read branch
					   echo "Pushing the commit"
								git push origin $branch
    fi
done
				 fi
					fi
				