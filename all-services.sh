#!/bin/bash
##This script was created by Joseph Mckenzie.
##If you enjoy this script and it helps, sweet you can view more of code at http://github.com/josephmckenzie

exists()
{
  command -v "$1" >/dev/null 2>&1
}

INSTALLGITCLI() {
if [ "$(uname)" == "Darwin" ]; then
			echo "Mac"
			if exists brew; then
					echo 'You have brew already installed'
				else
				 echo "installing needed Homebrew"
					ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
     brew doctor
				fi
			brew install git
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
		dist=`grep DISTRIB_ID /etc/*-release | awk -F '=' '{print $2}'`
		if [ "$dist" == "Ubuntu" ]; then
		  echo "installing with apt"
				if exists git; then
					echo 'You have the git cli already installed'
				else
					sudo apt-get update
					sudo apt-get upgrade
					sudo apt-get install git
				fi
		else
		  echo "Installing with yum"
				if exists git; then
					echo 'You have the git cli already installed'
				else
				 sudo yum upgrade
     sudo yum install git
				fi
		fi
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
echo "Win32"
echo "Click the link and install from the installer"
				https://git-for-windows.github.io/
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
				# Do something under 64 bits Windows NT platform
				echo "Click the link and install from the installer"
				https://git-for-windows.github.io/
				echo "Win64"
fi
}

INSTALLHEROKUCLI() {
if [ "$(uname)" == "Darwin" ]; then
			echo "Mac"
			if exists brew; then
					echo 'You have brew already installed'
				else
				 echo "installing needed Homebrew"
					ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
     brew doctor
				fi
   brew install heroku/brew/heroku
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
		dist=`grep DISTRIB_ID /etc/*-release | awk -F '=' '{print $2}'`
		if [ "$dist" == "Ubuntu" ]; then
		  echo "installing with apt"
				if exists heroku; then
					echo 'You have the heroku cli already installed'
				else
					sudo apt-add-repository 'deb http://toolbelt.herokuapp.com/ubuntu ./'
					curl http://toolbelt.herokuapp.com/apt/release.key | apt-key add -
					sudo apt-get update
					sudo apt-get install heroku-toolbelt
				fi
		else
		  echo "Installing without apt"
				if exists heroku; then
					echo 'You have the heroku cli already installed'
				else
				 wget https://toolbelt.heroku.com/install.sh
					sudo sh install.sh
					echo 'PATH="/usr/local/heroku/bin:$PATH"' >> ~/.profile
					sudo ln -s /usr/local/heroku/bin/heroku /usr/bin/heroku
					heroku
				fi
		fi
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
echo "Win32"
echo "Click the link and install from the installer"
				https://cli-assets.heroku.com/heroku-cli/channels/stable/heroku-cli-x86.exe
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
				# Do something under 64 bits Windows NT platform
				echo "Click the link and install from the installer"
				https://cli-assets.heroku.com/heroku-cli/channels/stable/heroku-cli-x64.exe
				echo "Win64"
fi



}

INSTALLAWSCLI() {
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
 if exists unzip; then
			unzip awscli-bundle.zip
			./awscli-bundle/install -b ~/bin/aws
			echo $PATH | grep ~/bin
			export PATH=~/bin:$PATH 
	else
	  if exists apt; then
		   apt install unzip -y
			else
			  yum install unzip -y
			fi
 fi
}

Create_new_repo() {
		echo "Please enter your profile name: "
		read -r Github_profilename
		echo "Please enter a new repo name: "
		read -r Guthub_repo_name
		curl --user "$Github_profilename" https://api.github.com/user/repos -d "{\"name\":\"$Guthub_repo_name\"}"
		echo "$Guthub_repo_name" >> README.md
		git init
		git add README.md
		echo "Please enter a commit message: "
		read -r Github_new_repo_message
		git commit -m "$Github_new_repo_message"
		git remote add origin https://github.com/"$Github_profilename"/"$Guthub_repo_name".git
		git push -u origin master
}

Github_add_check_commit(){
		git add .
		git status
		Github_commit_check="n"
		while [ "$Github_commit_check" == n ]; do
				#-n is saying do not put a newline afterwards
				echo -n " Does this look good? (y/n): "
				read -r ANSWER
				Github_commit_check=$(echo "$ANSWER" | tr '[:upper:]' '[:lower:]' | cut -c 1)
				if [ "$Github_commit_check" == n ]; then
						echo -e "Enter file to remove:"
						read -r Github_file
						git reset HEAD "$Github_file"
						git status
				else
						echo -e "Please enter a commit message: "
						read -r Github_commit_message
						git commit -m "$Github_commit_message"
						echo -e "Enter the branch you want to push to: "
						read -r Github_branch
						echo "Pushing the commit"
						git push origin "$Github_branch"
				fi
		done
}

Heroku_create_app() {
		echo "Please enter a new for your app: "
		read -r HerokuAppName
		heroku create "$HerokuAppName"
}

Heroku_add_check_commit(){
		git add .
		git status
		Github_commit_message="n"
		while [ "$Github_commit_message" == n ]; do
		#				// -n is saying do not put a newline afterwards
				echo -n " Does this look good? (y/n): "
				read -r ANSWER
				Github_commit_message=$(echo "$ANSWER" | tr '[:upper:]' '[:lower:]' | cut -c 1)
				if [ "$Github_commit_message" == n ]; then
						echo -e "Enter file to remove:"
						read -r file
						git reset HEAD "$file"
						git status
				else
						echo -e "Please enter a commit message: "
						read -r Heroku_commit_message
						git commit -m "$Heroku_commit_message"
						echo -e "Enter the branch you want to push to: "
						read -r Github_branch
						echo "Pushing the commit"
						git push heroku "$Github_branch"
				fi
		done
}

Heroku_add_config(){
		echo "Please enter your app name"
		read APPNAME
		echo "Please add a Config Variables key: "
		read -r configkey
		echo "Please enter a Config Variables value: "
		read -r envvconfigvalue
		heroku config:set --app "$APPNAME" "$configkey"="$envvconfigvalue"
}

Heroku_remove_config(){
echo "Please enter your app name"
read APPNAME
heroku config --app "$APPNAME"
echo "Please add a Config Variable to delete: "
read -r configkey
heroku config:unset --app "$APPNAME" "$configkey"
}

help() {
		cat help.txt
}

if [ "$1" == -h ]; then
		help
		exit 0
fi

Main_Menu_Options() {
echo -e "\n1) Github" 
echo "2) Heroku" 
echo "3) Amazon"
echo "4) Install prerequisites"
echo "5) Help" 
echo "6) Quit"
#echo -e ""
#menunumber=0
#for fn in ${options[@]}; do
# ((menunumber++))
# echo "$menunumber) $fn"
#done
}

Github_Menu_Options() {
echo -e "\n1) Create New Repo" 
echo "2) Pull" 
echo "3) Push" 
echo "4) Help" 
echo "5) Main Menu" 
echo "6) Quit"
#echo -e ""

#menunumber=0
#for fn in ${GithubOptions[@]}; do
# ((menunumber++))
# echo "$menunumber) $fn"
#done
}

Heroku_Menu_Options() {
echo -e "\n1) Current Apps"
echo "2) Open App in browser"
echo "3) Create New App"
echo "4) Push"
echo "5) Config Vars"
echo "6) View Logs"
echo "7) Help"
echo "8) Main Menu"
echo "9) Quit"
#echo -e ""
#hmenunumber=0
#for fn in ${HerokuOptions[@]}; do
# ((hmenunumber++))
# echo "$hmenunumber) $fn"
#done
}

Heroku_Var_Menu_Options() {
echo "1) Current Config vars"
echo "2) Add new Config var"
echo "3) Delete Config var"
echo "4) Help"
echo "5) Heroku Main Menu"
echo "6) Main Menu"
echo "7) Quit"
#echo -e ""
#hvmenunumber=0
#for fn2 in ${HerokuConfigOptions[@]}; do
# ((hvmenunumber++))
# echo "$hvmenunumber) $fn2"
#done
}

#Amazon_Menu_Options() {
##echo -e ""
##menunumber=0
##for fn in ${AmazonOptions[@]}; do
## ((menunumber++))
## echo "$menunumber) $fn"
##done
#}

  #PS3 is a default prompt statment for bash PS3 is for
    PS3='Please enter your choice: '
    options=("Github" "Heroku" "Amazon" "Install prerequisites" "Help" "Quit")
    select opt in "${options[@]}"
    do
      case $opt in
        "Github")
									if exists git; then
						    echo "all good git is installed"
						   else 
						    INSTALLGITCLI
						   fi
          GithubOptions=("Create New Repo" "Pull" "Push" "Help" "Main Menu" "Quit")
          select GithubOpt in "${GithubOptions[@]}"
          do
            case $GithubOpt in
              "Create New Repo")
                Create_new_repo
                echo "Creating New Repo"
                break
                ;;
              "Pull")
                git pull origin master
                echo "Pulling code from Repo"
                break
                ;;
              "Push")
                Github_add_check_commit
                echo "Pushing Code"
                break
                ;;					
              "Help")
                echo "Displaying Help"
                help
                break 2
                ;;
														"Main Menu")
														 echo "Should echo br 1 next"
																break
																;;		
              "Quit")
														  echo "Quit Program (br 2)"
                break 2
                ;;
              *) echo invalid option;;
            esac
          done
										echo "Br 1"
          Main_Menu_Options
          ;;
        "Heroku")
								if exists heroku; then
						    echo "all good heroku is installed"
						   else 
						    INSTALLHEROKUCLI
						   fi
          HerokuOptions=("Current Apps" "Open App in browser" "Create New App" "Push" "Config Vars" "View Logs" "Help" "Main Menu" "Quit")
          select HerokuOpt in "${HerokuOptions[@]}"
          do
            case $HerokuOpt in
												  "Current Apps")
														echo "Current List of your apps"
														heroku apps
														break
														;;
														"Open App in browser")
														echo "Please enter an app name"
														read HerokuAppName
														heroku open --app "$HerokuAppName"
														break
														;;
              "Create New App")
														  echo "Please enter a name for your new app"
                Heroku_create_app
                echo "Creating new Heroku app"
                break
                ;;
														"App info")
														echo "Please enter your app name"
														read HerokuAppName
														heroku info --app "$HerokuAppName"
														break
														;;
              "Push")
                Heroku_add_check_commit
                echo "Pushing Code"
                break
                ;;
              "Config Vars")
																				HerokuConfigOptions=("Current Config vars" "Add new Config var" "Delete Config var" "Help" "Heroku Main Menu" "Main Menu" "Quit")
																select HerokuConfigOpt in "${HerokuConfigOptions[@]}"
																do
																		case $HerokuConfigOpt in
																				"Current Config vars")
																						echo "Please enter your app name"
																						read HEROKUAPP
																						heroku config --app "$HEROKUAPP"
																						echo "Current Config vars"
#																					  break
																							echo "should show current menu again, thus keeping in the loop"
																						Heroku_Var_Menu_Options
																						;;
																				"Add new Config var")
																						Heroku_add_config
																						echo "Adding Config variable"
#																						break
																						echo "should show current menu again, thus keeping in the loop"
																						Heroku_Var_Menu_Options
																						;;
																				"Delete Config var")
																						Heroku_remove_config
																						echo "Removing Config variable"
#																						break
			                   echo "should show current menu again, thus keeping in the loop"
																						Heroku_Var_Menu_Options
																						;;
																				"Help")
																						echo "Displaying Help"
																						help
																						break 3
																						;;
																				"Heroku Main Menu")
																				echo "Should echo br 1 next"
																						break 
																						;;
																				"Main Menu")
																				echo "Should bring to main menu"
																			  	break 2
																				  ;;
																				"Quit")
																				echo "Should Quit program"
																						break 3
																						;;
																				*) echo invalid option;;
																		esac
																done 
																echo "Br1"
																Heroku_Menu_Options
                ;;
														"View Logs")
														echo "Please enter your app name"
														read HerokuAppName
														heroku logs --app "$HerokuAppName"
														break
														;;
              "Help")
                echo "Displying Help"
                help
                break 2
                ;;
              "Main Menu")
														echo "Should echo br 1 next"
                break
                ;;
														"Quit")
														echo "Should exit program"
														break 2
														;;
              *) echo invalid option;;
            esac
          done
										echo "Br 1"
          Main_Menu_Options
          ;;
        "Amazon")
								 if exists aws; then
									  echo "AWS CLI installed already"
									else
									  INSTALLAWSCLI
									fi
          AmazonOptions=("IAM Config" "AWS Config" "Lambda" "S3 Bucket" "Help" "Quit")
          select AmazonOpt in "${AmazonOptions[@]}"
          do
            case $AmazonOpt in
              "AWS Config")
                aws configure
                echo "Configuring AWS"
                Amazon_Menu_Options
                ;;
              "IAM Config")
                AmazonIAMOptions=("New CLI User" "IAM policies" "IAM Roles" "Help" "Quit")
                select AmazonIAMOpt in "${AmazonIAMOptions[@]}"
                do
                  case $AmazonIAMOpt in
                    "New CLI User")
                      echo "Please enter a name for your new IAM user"
                      read -r IAMUSER
                      aws iam create-user --user-name "$IAMUSER"
                      echo "Creating new IAM user"
                      echo "Please enter a Group name"
                      read -r IAMGROUP
                      aws iam create-group --group-name "$IAMGROUP"
                      echo "Creating new IAM group"
                      echo "Adding IAM user to group"
                      aws iam add-user-to-group --user-name "$IAMUSER" --group-name "$IAMGROUP"
                      echo "Please enter a password for your IAM user"
                      read -r IAMPASSWORD
                      aws iam create-login-profile --user-name "$IAMUSER" --password "$IAMPASSWORD"
                      echo "Creating IAM password"
                      aws iam create-access-key --user-name "$IAMUSER"
                      echo "Please store the secret and access key somewhere SAFE"
                      break
                      ;;
                    "IAM policies")
                      IAMPOLICIES=("Lambda" "S3" "Help" "Quit")
                      select IAMPOLICY in "${IAMPOLICIES[@]}"
                      do
                        case $IAMPOLICY in
                          "Lambda")
                            echo "Please enter your IAM username"
                            read -r IAMUSER
                            echo "Please enter a Policy name for your new policy"
                            read -r POLICYNAME
                            jq -n --arg appname "LambdaPolicy" '{"Version": "2012-10-17","Statement": [{"Effect": "Allow","Action": ["iam:*", "lambda:*"],"Resource": "*" }]}' > lambda_policy.json
                            aws iam put-user-policy --user-name "$IAMUSER" --policy-name "$POLICYNAME" --policy-document file://lambda_policy.json
                            echo "Please enter the following information"
                            aws configure --profile "$IAMUSER"
                            echo "Creating Lambda Policy"
                            break
                            ;;
                          "S3")
                            echo "Creating S3 Policy"
                            break
                            ;;
                          "Help")
                            echo "Displaying Help"
                            help
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
                    "IAM Roles")
                      IAMROLESS=("Lambda" "S3" "Help" "Quit")
                      select IAMROLES in "${IAMROLESS[@]}"
                      do
                        case $IAMROLES in
                          "Lambda")
                            echo "Please enter a name for your new role"
                            read -r ROLENAME
                            jq -n --arg appname "$ROLENAME" '{"Version": "2012-10-17","Statement": [{"Effect": "Allow","Principal": { "AWS" : "*" },"Action": "sts:AssumeRole"}]}' > "$ROLENAME".json
                            aws iam create-role --role-name "$ROLENAME" --assume-role-policy-document file://"$ROLENAME".json
                            echo "Please Write down your arn in a safe place"
                            echo "Creating Lambda Role"
                            break
                            ;;
                          "S3")
                            echo "Creating S3 Role"
                            break
                            ;;
                          "Help")
                            echo "Displaying Help"
                            help
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
                      echo "Displaying Help"
                      help
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
              "Lambda")
                LambdaOptions=("Create New Lambda Function" "Update Lambda Function" "Add/Update Enviromental Variables" "Help" "Quit")
                select LambdaOpt in "${LambdaOptions[@]}"
                do
                  case $LambdaOpt in
                    "Create New Lambda Function")
                      echo "Please enter a region"
                      echo "Ex: us-west-2"
                      read -r REGION
                      echo "Please enter a name for your Lambda function"
                      read -r FUNCTIONNAME
                      echo "Please enter the name of your lambda zip file (NO extension required)"
                      read -r ZIPFILE
                      echo "Please enter your ARN"
                      echo "Ex: arn:aws:iam::22*******74:role/YOURIAMROLENAME"
                      read -r YOURARN
                      echo "Please enter your handler"
                      echo "Ex: main.add (Python)"
                      echo "Ex: index.handler (Node.js)"
                      read -r HANDLER
                      echo "Please enter a run time"
                      echo "Ex: python2.7 (Python)"
                      echo "Ex: nodejs4.3 (Node.js)"
                      read -r RUNTIME
                      echo "Please enter your IAM username"
                      read -r PROFILE
                      aws lambda create-function --region "$REGION" --function-name "$FUNCTIONNAME" --zip-file fileb://"$ZIPFILE".zip --role "$YOURARN" --handler "$HANDLER" --runtime "$RUNTIME" --profile "$PROFILE"
                      echo "Creating new Lambda Function"
                      break
                      ;;
                    "Update Lambda Function")
                      echo "Please enter your Lambda function name"
                      read -r FUNCTIONNAME
                      echo "Please enter the name of your Labda zip file (No need for extension)"
                      read -r ZIPFILE
                      aws lambda update-function-code --function-name "$FUNCTIONNAME" --zip-file fileb://"$ZIPFILE".zip
                      echo "Updating Lambda Function"
                      break
                      ;;
                    "Add/Update Enviromental Variables")
                      echo "Please enter the Lambda function name"
                      read -r LAMBDANAME
                      echo "Please enter a Env Key"
                      read -r ENVKEY
                      echo "Please enter a Env Value"
                      read -r ENVVALUE
                      aws lambda update-function-configuration --function-name "$LAMBDANAME" --environment Variables={"$ENVKEY"="$ENVVALUE"}
                      echo "Updating Enviromental Variables"
                      break
                      ;;
                    "Help")
                      echo "Displying Help"
                      help
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
              "S3 Bucket")
                S3BucketOptions=("Create New S3 Bucket" "Update S3 Bucket" "Delete S3 Bucket" "Help" "Quit")
                select S3BucketOpt in "${S3BucketOptions[@]}"
                do
                  case $S3BucketOpt in
                    "Create New S3 Bucket")
                      echo "Please enter a bucket name"
																						read S3BUCKETNAME
																						aws s3 mb s3://"$S3BUCKETNAME"
                      echo "Creating new S3 Bucket"
                      break
                      ;;
                    "Update S3 Bucket")
																						echo "Please choose an option"
																						S3BucketUploadOptions=("Upload whole folder" "Upload single file" "Help" "Quit")
																						select S3BucketUploadOpt in "${S3BucketUploadOptions[@]}"
																						do
																								case $S3BucketUploadOpt in
																										"Upload whole folder")
																										  echo "Date Created               Bucket Name"
																				        aws s3 ls
																												echo "Please enter your S3Bucket name"
																						      read S3BUCKETNAME
																												 aws s3 sync . s3://"$S3BUCKETNAME"/
																												echo "Uploading to S3 Bucket"
																												break
																												;;
																										"Upload single file")
																										  echo "Date Created               Bucket Name"
																				        aws s3 ls
																												echo "Please enter your S3Bucket name"
																						      read S3BUCKETNAME
																												echo "Please enter the name of the file you wish to upload"
																												read FILENAMETOUPLOAD
																												aws s3 cp "$FILENAMETOUPLOAD" s3://"$S3BUCKETNAME"
																												echo "Uploading to S3 Bucket"
																												break
																												;;
																										"Help")
																												echo "Displaying Help"
																												help
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
                    "Delete S3 Bucket")
																				 echo "Date Created               Bucket Name"
																				 aws s3 ls
                     echo "Please enter a bucket name to delete"
																					read S3BUCKETNAME
																					echo "Caution are you sure you want to delete your bucket and all its contents? (Y/n)"
																					read S3DELETE
																					if [[ "$S3DELETE" == [Yy] ]]; then
																							aws s3 rb s3://"$S3BUCKETNAME" --force
																					else 
																					  echo "You chose not delete your bucket"
																					  exit 0
																				 fi
																					echo "Deleting S3 Bucket"
                     break
                      ;;
                    "Help")
                      echo "Displaying Help"
                      help
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
                help
                echo "Displaying Help"
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
								"Install prerequisites")
								   PreReqOptions=("Github CLI" "Heroku CLI" "Amazon CLI" "Help" "Main Menu" "Quit")
          select PreReqOpt in "${PreReqOptions[@]}"
          do
            case $PreReqOpt in
              "Github CLI")
                INSTALLGITCLI
                break
                ;;
              "Heroku CLI")
                if exists heroku; then
																		echo 'You have the heroku cli already installed'
																else
																		INSTALLHEROKUCLI
																fi
                break
                ;;
              "Amazon CLI")
                if exists heroku; then
																		echo 'You have the heroku cli already installed'
																else
																		INSTALLGITCLI
																fi
                break
                ;;					
              "Help")
                echo "Displaying Help"
                help
                break 2
                ;;
														"Main Menu")
														 echo "Should echo br 1 next"
																break
																;;		
              "Quit")
														  echo "Quit Program (br 2)"
                break 2
                ;;
              *) echo invalid option;;
            esac
          done
										echo "Br 1"
          Main_Menu_Options
          ;;										
#										break
#										;;		
        "Help")
          echo "You chose the Readme"
										help
          break
#									Main_Menu_Options
          ;;
        "Quit")
          break
          ;;
        *) echo invalid option;;
      esac
    done