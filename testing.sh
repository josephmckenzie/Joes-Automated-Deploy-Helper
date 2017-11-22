##!/bin/env bash
add_check_commit(){
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
}

	echo  "Where would you like to push/commit code to today? :"
	echo -e "1. Github"
	echo -e "2. Heroku"
	echo -e "3. Amazon"
	echo -n "Enter a number: "
		read MainService 
		if [ "$MainService" = 1 ]; then
				echo "What would you like to do today?"
#				echo -e "3. Create new Repo"
				echo -e "1. Pull"
				echo -e "2. Push"
				echo -n "Enter a number: "
				read Github
		if [ "$Github" = 1 ]; then
				git pull origin master
		elif [ "$Github" = 2 ]; then
				add_check_commit
		elif [ "$Github" = 3 ]; then
			echo "Please enter a new repo name: "
		
		fi
		elif [ "$MainService" = 2 ]; then
	   echo "What would you like to do today?"
	   echo -e "1. Create new App"
				echo -e "2. Push"
				echo -e "3. Add Config Variables"
				echo -n "Enter a number: "
				read Heroku
		if [ "$Heroku" = 3 ]; then
		  echo "Please add a Config Variables key: "
				read configkey
	   echo "Please enter a Config Variables value: "
				read envvconfigvalue
    heroku config:set $configkey=$envvconfigvalue	
				elif [ "$Heroku" = 2 ]; then
	   add_check_commit
				elif [ "$Heroku" = 1 ]; then
				echo "Please enter a new for your app: "
				read HerokuAppName
				heroku create $HerokuAppName
		fi
		else
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
				