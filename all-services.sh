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
      echo "Please add a Config Variables key: "
      read -r configkey
      echo "Please enter a Config Variables value: "
      read -r envvconfigvalue
      heroku config:set "$configkey"="$envvconfigvalue"
    }

    help() {
      cat help.txt
    }

    if [ "$1" == -h ]; then
      help
      exit 0
    fi



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
          HerokuOptions=("Create New App" "Push" "Config Vars" "Help" "Quit")
          select HerokuOpt in "${HerokuOptions[@]}"
          do
            case $HerokuOpt in
              "Create New App")
                Heroku_create_app
                echo "Creating new Heroku app"
                break
                ;;
              "Push")
                Heroku_add_check_commit
                echo "Pushing Code"
                break
                ;;
              "Config Vars")
                Heroku_add_config
                echo "Adding Config Variables"
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
        "Amazon")
          AmazonOptions=("IAM Config" "AWS Config" "Lambda" "S3 Bucket" "Help" "Quit")
          select AmazonOpt in "${AmazonOptions[@]}"
          do
            case $AmazonOpt in
              "AWS Config")
                aws configure
                echo "Configuring AWS"
                break
                ;;
              "IAM Config")
                AmazonOptions=("New CLI User" "IAM policies" "IAM Roles" "Help" "Quit")
                select AmazonOpt in "${AmazonOptions[@]}"
                do
                  case $AmazonOpt in
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
                echo "you chose S3 Bucket"
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
          break
          ;;
        "Quit")
          break
          ;;
        *) echo invalid option;;
      esac

    done
