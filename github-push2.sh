##!/bin/env bash

pause(){
 read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
}
#
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
				  echo -n "Enter the branch name you wish to pull from: "
						read GithubBranch
						git pull origin $GithubBranch
						 
				elif [ "$Github" = 2 ]; then
						git add .
						git status
						echo -n "Please verify your commit, does it look correct?"
						read verify
						if [ "$verify" = y ] || [ "$verify" = Y ]; then
						echo -n "Enter the branch name you wish to push to: "
						elif [ "$verify" = n ] || [ "$verify" = N ]; then
						echo -n "Please enter the name of the file you wish to remove: "
      fi
						git commit -m "blah"
						git push origin $GithubBranch		
						fi
    elif [ "$MainService" = 2 ]; then
      echo "Heroku"
				elif [ "$MainService" = 3 ]; then
      echo "Amazon"        
						echo  "What service would you like to update? :"
				echo -e "1. Amazon's Lambda"
				echo -e "2. Amazon's S3 Bucket"
				echo -e "3. Amazon's Codedeploy"
				echo -n "Enter a number: "
    read AmazonService 
    if [ "$AmazonService" = 1 ]; then
      echo "Amazon's Lambda"
    elif [ "$AmazonService" = 2 ]; then
      echo "Amazon's S3 Bucket"
				elif [ "$AmazonService" = 3 ]; then
      echo "Amazon's Codedeploy"        
    fi
    fi
				 
				