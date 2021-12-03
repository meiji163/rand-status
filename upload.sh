#!/bin/bash 

git init && git add . 
git commit -m"init" 

for repo in $@
do
  gh repo create "$repo" --source=. --private --push || exit 1
  git remote rm origin
done
