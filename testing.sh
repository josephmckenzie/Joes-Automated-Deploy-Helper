##!/bin/env bash
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
				 
				