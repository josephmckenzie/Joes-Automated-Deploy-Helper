#!/bin/bash

git add .
git status
read -n 1 -s -r -p "If your commit looks right, Press any key to continue"
git commit -m "$1"
git push $2 $3
