#!/bin/bash
tmux new-session -d -s debugger -x "$(tput cols)" -y "$(tput lines)"
tmux source ~/.tmux.gdb.conf
