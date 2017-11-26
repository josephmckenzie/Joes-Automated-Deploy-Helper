#!/bin/bash


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
		echo -e "\n1) ${options[0]}"
		echo "2) ${options[1]}"
		echo "3) ${options[2]}"
		echo "4) ${options[3]}"
		echo "5) ${options[4]}"
}

Github_Menu_Options() {
  echo -e "\n1) ${GithubOptions[0]}"
		echo "2) ${GithubOptions[1]}"
		echo "3) ${GithubOptions[2]}"
		echo "4) ${GithubOptions[3]}"
		echo "5) ${GithubOptions[4]}"
}
Heroku_Menu_Options() {
  echo -e "\n1) ${HerokuOptions[0]}"
		echo "2) ${HerokuOptions[1]}"
		echo "3) ${HerokuOptions[2]}"
		echo "4) ${HerokuOptions[3]}"
		echo "5) ${HerokuOptions[4]}"
		echo "6) ${HerokuOptions[5]}"
		echo "7) ${HerokuOptions[6]}"
		echo "8) ${HerokuOptions[7]}"
}

Amazon_Menu_Options() {
  echo -e "\n1) ${AmazonOptions[0]}"
		echo "2) ${AmazonOptions[1]}"
		echo "3) ${AmazonOptions[2]}"
		echo "4) ${AmazonOptions[3]}"
		echo "5) ${AmazonOptions[4]}"
		echo "6) ${AmazonOptions[5]}"
		echo "7) ${AmazonOptions[6]}"
		echo "8) ${AmazonOptions[7]}"
}
  #PS3 is a default prompt statment for bash PS3 is for
    PS3='Please enter your choice: '
    options=("Github" "Heroku" "Amazon" "Help" "Quit")
    select opt in "${options[@]}"
    do
      case $opt in
        "Github")
          GithubOptions=("Create New Repo" "Pull" "Push" "Help" "Quit")
          select GithubOpt in "${GithubOptions[@]}"
          do
            case $GithubOpt in
              "Create New Repo")
                Create_new_repo
                echo "Creating New Repo"
#                break
																Github_Menu_Options
                ;;
              "Pull")
                git pull origin master
                echo "Pulling code from Repo"
#                break
																Github_Menu_Options
                ;;
              "Push")
                Github_add_check_commit
                echo "Pushing Code"
#                break
                Github_Menu_Options
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
          break 2
          ;;
        "Heroku")
          HerokuOptions=("Current Apps" "Open App in browser" "Create New App" "Push" "Config Vars" "View Logs" "Help" "Quit")
          select HerokuOpt in "${HerokuOptions[@]}"
          do
            case $HerokuOpt in
												  "Current Apps")
														echo "Current List of your apps"
														heroku apps
#														break
														Heroku_Menu_Options
														;;
														"Open App in browser")
														echo "Please enter an app name"
														read HerokuAppName
														heroku open --app "$HerokuAppName"
#														break
														Heroku_Menu_Options
														;;
              "Create New App")
														  echo "Please enter a name for your new app"
                Heroku_create_app
                echo "Creating new Heroku app"
#                break
																Heroku_Menu_Options
                ;;
														"App info")
														echo "Please enter your app name"
														read HerokuAppName
														heroku info --app "$HerokuAppName"
#														break
														Heroku_Menu_Options
														;;
              "Push")
                Heroku_add_check_commit
                echo "Pushing Code"
#                break
																Heroku_Menu_Options
                ;;
              "Config Vars")
																				HerokuConfigOptions=("Current Config vars" "Add new Config var" "Delete Config var" "Help" "Quit")
																select HerokuConfigOpt in "${HerokuConfigOptions[@]}"
																do
																		case $HerokuConfigOpt in
																				"Current Config vars")
																						echo "Please enter your app name"
																						read HEROKUAPP
																						heroku config --app "$HEROKUAPP"
																						echo "Current Config vars"
																						break 2
#																						Heroku_Menu_Options
																						;;
																				"Add new Config var")
																						Heroku_add_config
																						echo "Adding Config variable"
																						break
#																						Heroku_Menu_Options
																						;;
																				"Delete Config var")
																						Heroku_remove_config
																						echo "Removing Config variable"
																						break
#																						Heroku_Menu_Options
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
														"View Logs")
														echo "Please enter your app name"
														read HerokuAppName
														heroku logs --app "$HerokuAppName"
#														break
														Heroku_Menu_Options
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
          Main_Menu_Options
										
          ;;
        "Amazon")
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