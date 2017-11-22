##!/bin/env bash

git add .
git status

YANSWER="n"
YORN="n"
while [ "$YANSWER" == "$YORN" ]; do
    git status
    echo -n " Does this look right?: "
    read ANSWER
    YANSWER=`echo $ANSWER | tr [:upper:] [:lower:] | cut -c 1`
    if [ "$YANSWER" == "$YORN" ]; then
      read filename
						echo -e "Enter the name of file to remove"
						git reset HEAD $filename
    fi
				git commit -m "testing while loop"
				git push origin master
done
				 
				