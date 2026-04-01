#!/usr/bin/env bash

cd ~/.dotfiles/

#turn on ssh agent and  add the key
eval "$(ssh-agent -s)"

ssh-add ~/.ssh/github

#shoutout chatu za tenhle script
ahead=$(git rev-list --count origin/master..HEAD)

if [ "$ahead" -eq 0 ]; then
  echo "✅ Není co squashovat – všechno už je pushnutý."
  exit 0
fi

# Datum ve formátu YYYY-MM-DD
today=$(date +"%Y-%m-%d")

# Squashne všechno do jednoho commitu
git reset --soft HEAD~$ahead
git commit -m "🧠 Squashed auto-commits for $today"
git push origin master

echo "✅ Push hotovej na master s jedním squashed commitem: $today"
