#!/bin/bash

if [ $(tmux display -p -F "#{session_name}") = "scratch" ]; then
  # Popup is open, close it
  tmux detach-client
else
  # Popup is closed, open it
  tmux display-popup -w 80% -h 80% -E "tmux new-session -A -s scratch"
fi

  #tmux display-popup -E "tmux detach-client"
# tmux_session_name = $(tmux display -p -F "#{session_name}")
# Check if the popup is open
