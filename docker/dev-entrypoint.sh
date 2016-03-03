#!/bin/bash

tmux -2 new-session -d -s baoqu

tmux new-window -t baoqu:1 -n 'front'
tmux select-window -t baoqu:1
tmux send-keys -t baoqu 'cd app-front' C-m
tmux send-keys -t baoqu './scripts/figwheel' C-m

tmux new-window -t baoqu:2 -n 'back'
tmux select-window -t baoqu:2
tmux send-keys -t baoqu 'cd app-back' C-m
tmux send-keys -t baoqu 'lein run' C-m

tmux rename-window -t baoqu:0 'layout'
tmux select-window -t baoqu:0
tmux send-keys -t baoqu 'cd app-front/layout' C-m
tmux send-keys -t baoqu 'gulp' C-m

tmux -2 attach-session -t baoqu
