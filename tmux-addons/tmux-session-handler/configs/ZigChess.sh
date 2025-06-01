#!/bin/bash

tmux split-window -v -t "$1" -c "#{pane_current_path}"
tmux send-keys -t "$1" "git status" C-m
tmux send-keys -t "$1" "source ./buildcommands.sh" C-m
tmux select-pane -t "$1" -D
tmux send-keys -t "$1" "vim" C-m
