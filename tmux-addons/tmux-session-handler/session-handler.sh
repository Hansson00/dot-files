#!/bin/bash

# Source the configuration file
source "$HOME/.local/tmux-addons/tmux-session-handler/tmux_session_options.conf"

# Find all Git repositories under BASE_DIR, excluding patterns
GIT_REPOS=$(fd -d 3 --hidden --type d ".git" "$BASE_DIR" --exec dirname {} \
  | grep -Ev "$(IFS="|"; echo "${EXCLUDE_PATTERNS[*]}")" \
  | sort -u)

# Combine options
OPTIONS=$(echo -e "${ADDITIONAL_OPTIONS[*]}\n$GIT_REPOS")

# Prompt the user to select a directory
REPO=$(echo "$OPTIONS" | tr ' ' '\n' | fzf --prompt="Select a directory: ") 

if [ -z "$REPO" ]; then
    echo "No repository selected. Exiting..."
    exit 1
fi

# Get the session name from the selected directory
SESSION_NAME=$(basename "$REPO")

# Check if the session already exists
tmux has-session -t "$SESSION_NAME" 2>/dev/null

if [ $? -eq 0 ]; then
    # Session exists
    if [ "$TMUX" ]; then
        tmux switch-client -t "$SESSION_NAME"
    else
        tmux attach-session -t "$SESSION_NAME"
    fi
else
    # Create a new session
    if [ "$TMUX" ]; then
        tmux new-session -s "$SESSION_NAME" -c "$REPO" -d >/dev/null
        tmux switch-client -t "$SESSION_NAME"
    else
        tmux new-session -s "$SESSION_NAME" -c "$REPO"
    fi

    # Run commands from the corresponding config file, if it exists
    CONFIG_FILE="$HOME/.local/tmux-addons/tmux-session-handler/configs/$SESSION_NAME.sh"

    if [ -f "$CONFIG_FILE" ]; then
      source $CONFIG_FILE $SESSION_NAME
    fi

fi

