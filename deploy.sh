#!/bin/bash
# usage: ./deploy.sh "Your commit message here"

MESSAGE=${1:-"Update code"}
BRANCH=${2:-"main"}

git add .
git commit -m "$MESSAGE"
git push origin $BRANCH

