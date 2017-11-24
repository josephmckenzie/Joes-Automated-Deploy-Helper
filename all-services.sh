#!/bin/bash
#Ps3 is a default prompt statment for bash PS3 is for 
PS3='Please enter your choice: '
options=("Github" "Heroku" "Amazon (Work in Progress)" "Help" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Github")
            GithubOptions=("Create New Repo" "Pull" "Push" "Quit")
select GithubOpt in "${GithubOptions[@]}"
do
    case $GithubOpt in
        "Create New Repo")
            echo "You chose Create New Repo"
												break
            ;;
        "Pull")
            echo "You chose Pull"
												break
            ;;
        "Push")
            echo "you chose Push"
												break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
				
done
												break
            ;;
        "Heroku")
                    HerokuOptions=("Create New App" "Push" "Config Vars" "Quit")
select HerokuOpt in "${HerokuOptions[@]}"
do
    case $HerokuOpt in
        "Create New App")
            echo "You chose Create New App"
												break
            ;;
        "Push")
            echo "You chose Push"
												break
            ;;
        "Config Vars")
            echo "you chose Config Vars"
												break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
				
done
												break
            ;;
        "Amazon")
                      AmazonOptions=("IAM Config" "Lambda" "S3 Bucket" "Quit")
select AmazonOpt in "${AmazonOptions[@]}"
do
    case $AmazonOpt in
        "IAM Config")
            echo "You chose IAM config"
												break
            ;;
        "Lambda")
            echo "You chose Lambda"
												break
            ;;
        "S3 Bucket")
            echo "you chose S3 Bucket"
												break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
				
done
												break
            ;;
								"Help")
								    echo "You chose the Readme"
												break
												;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
				
done
#add_check_commit(){
#git add .
#				git status
#				commitcheck="n"
#				while [ "$commitcheck" == n ]; do
##				// -n is saying do not put a newline afterwards
#				echo -n " Does this look good? (y/n): "
#				read ANSWER
#				commitcheck=`echo $ANSWER | tr [:upper:] [:lower:] | cut -c 1`
#				if [ "$commitcheck" == n ]; then
#						echo -e "Enter file to remove:"
#						read file
#						git reset HEAD $file
#						git status
#			 else 
#						echo -e "Please enter a commit message: "
#						read commitmessage
#						git commit -m "$commitmessage"
#						echo -e "Enter the branch you want to push to: "
#						read branch
#						echo "Pushing the commit"
#						git push origin $branch
#				fi
#				done
#}
#
#help() {
#cat help.txt
#}
#
#if [ "$1" == -h ]; then
# help
#	exit 0
#	fi
#
#	openingmessage() {
#	echo  "Where would you like to push/commit code to today? :"
#	echo -e "1. Github"
#	echo -e "2. Heroku"
#	echo -e "3. Amazon"
#	echo -n "Enter a number: "
#	}
#	   doWithAmazon() {
#	    echo "What would you like to do today?"
#				 echo -e "1. Add new IAM user"
#				 echo -e "2. Add new IAM role"
#				 echo -e "3. Set premissions and policies"
#					echo -n "Please enter a number: "
#	}
#	
#	goWithGitHub() {
#   	echo "What would you like to do today?"
#				echo -e "1. Create new Repo"
#				echo -e "2. Pull"
#				echo -e "3. Push"
#				echo -n "Enter a number: "
#				read Github
#
#	}
#	
#	 openingmessage
#		read MainService 
#		if [ "$MainService" = 1 ]; then
#				goWithGitHub
#		  if [ "$Github" = 1 ]; then				
#						echo "Please enter your profile name: "
#			   read profilename
#			   echo "Please enter a new repo name: "
#			   read RepoName
#			   curl --user $profilename https://api.github.com/user/repos -d "{\"name\":\"$RepoName\"}"
#      echo "$RepoName" >> README.md
#      git init
#      git add README.md
#				  echo "Please enter a commit message: "
#				  read createrepocommitmessage
#      git commit -m "$createrepocommitmessage"
#      git remote add origin https://github.com/"$profilename"/"$RepoName".git
#      git push -u origin master
#		  elif [ "$Github" = 2 ]; then
#						git pull origin master
#		  elif [ "$Github" = 3 ]; then
#				  add_check_commit
#		  fi
#		elif [ "$MainService" = 2 ]; then
#	   	echo "What would you like to do today?"
#	   	echo -e "1. Create new App"
#					echo -e "2. Push"
#					echo -e "3. Add Config Variables"
#					echo -n "Enter a number: "
#					read Heroku
#		if [ "$Heroku" = 3 ]; then
#		  echo "Please add a Config Variables key: "
#					read configkey
#	   echo "Please enter a Config Variables value: "
#					read envvconfigvalue
#    	heroku config:set $configkey=$envvconfigvalue	
#				elif [ "$Heroku" = 2 ]; then
#	   	add_check_commit
#				elif [ "$Heroku" = 1 ]; then
#					echo "Please enter a new for your app: "
#					read HerokuAppName
#					heroku create $HerokuAppName
#		fi
#		elif [ "$MainService" = 3 ]; then
#					echo  "What service would you like to update? :"
#					echo -e "1. Manage IAM users, roles, policies"
#					echo -e "2. Amazon's Lambda"
#					echo -e "3. Amazon's S3 Bucket"
#					echo -e "4. Amazon's Codedeploy"
#					echo -n "Enter a number: "
#    read AmazonService 
#				if [ "$AmazonService" = 1 ]; then
#				doWithAmazon
#				read AWS_IAM
#				if [ "$AWS_IAM" = 1 ]; then
#				 echo "IAM user"
#				elif [ "$AWS_IAM" = 2 ]; then
#				 echo "IAM ROLE"
#			 elif [ "$AWS_IAM" = 3 ]; then
#				 echo "Premissions and Policies"
#				fi
#    elif [ "$AmazonService" = 2 ]; then
#      echo "Amazon's Lambda"
#    elif [ "$AmazonService" = 3 ]; then
#      echo "Amazon's S3 Bucket"
#				elif [ "$AmazonService" = 4 ]; then
#      echo "Amazon's Codedeploy"   
#				else
#					 echo -e "\n*** Please pick from the menu ***"
#					 doWithAmazon
#    fi				
#
# fi	
#	
#				
