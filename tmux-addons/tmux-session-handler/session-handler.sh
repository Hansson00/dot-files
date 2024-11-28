#!/bin/bash

BASE_DIR="$HOME/Documents/"
GIT_REPOS=$(fdfind --hidden --type d ".git" "$BASE_DIR" --exec dirname {} | sort -u)

OPTIONS=$(echo -e "$HOME\n$HOME/.local/programs/SavvyCAN/\n$HOME/Documents/school/\n$GIT_REPOS")

REPO=$(echo "$OPTIONS" | fzf --prompt="Select a directory: ") 

if [ -z "$REPO" ]; then
    echo "No repository selected. Exiting..."
    exit 1
fi

SESSION_NAME=$(basename "$REPO")

tmux has-session -t "$SESSION_NAME" 2>/dev/null

if [ $? -eq 0 ]; then

    if [ "$TMUX" ]; then
      tmux switch-client -t "$SESSION_NAME"
    else
      tmux a -t "$SESSION_NAME"
    fi
else
    if [ "$TMUX" ]; then
      tmux new-session -s "$SESSION_NAME" -c "$REPO" -d>/dev/null
      tmux switch-client -t "$SESSION_NAME"
    else
      tmux new-session -s "$SESSION_NAME" -c "$REPO"
    fi
fi

