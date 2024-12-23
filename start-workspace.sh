#!/bin/bash

#https://ryan.himmelwright.net/post/scripting-tmux-workspaces/

# first argument is project folder, if empty use current dir
if [ -z "$1" ]; then 
	echo "opening workspace in current dir"
else
	cd $1
fi

# Session Name
session="neovim"

# Start New Session with our name
tmux new-session -d -s $session

# rename window
tmux rename-window -t $session:1 "main"

# split session window
tmux split-window -t "main"

# resize
tmux resize-pane -t main.2 -y 15%

# open neovim
tmux send-keys -t main.1 'nvim +NvimTreeOpen' C-m

# switch to neovim pane
tmux select-pane -t main.1

# attach to session
tmux attach -t $session
