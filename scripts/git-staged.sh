#!/bin/bash
SUBFOLDER="$1"

if [ -n "$SUBFOLDER" ]; then
  if git -C "$SUBFOLDER" rev-parse --git-dir > /dev/null 2>&1; then
    echo "REPO: $SUBFOLDER"
    echo "--- STATUS ---"
    git -C "$SUBFOLDER" status 2>/dev/null
    echo "--- STAGED DIFF ---"
    git -C "$SUBFOLDER" diff --staged 2>/dev/null
  else
    echo "Error: '$SUBFOLDER' is not a git repository."
  fi
elif git rev-parse --git-dir > /dev/null 2>&1; then
  echo "REPO: ."
  echo "--- STATUS ---"
  git status
  echo "--- STAGED DIFF ---"
  git diff --staged
else
  found=0
  for gitdir in $(find . -maxdepth 2 -name ".git" -type d 2>/dev/null | sort); do
    repo=$(dirname "$gitdir")
    staged=$(git -C "$repo" diff --staged 2>/dev/null)
    if [ -n "$staged" ]; then
      echo "REPO: $repo"
      echo "--- STATUS ---"
      git -C "$repo" status 2>/dev/null
      echo "--- STAGED DIFF ---"
      echo "$staged"
      echo ""
      found=1
    fi
  done
  if [ "$found" = "0" ]; then
    echo "No staged changes found in any repository."
    for gitdir in $(find . -maxdepth 2 -name ".git" -type d 2>/dev/null | sort); do
      repo=$(dirname "$gitdir")
      echo "REPO: $repo (nothing staged)"
      git -C "$repo" status 2>/dev/null
      echo ""
    done
  fi
fi
