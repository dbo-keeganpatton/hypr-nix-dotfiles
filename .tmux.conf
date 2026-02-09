# Set the prefix key to Ctrl+a
set -g prefix C-a
unbind C-b
bind C-a send-prefix

# Start windows and panes at index 1 instead of 0
set -g base-index 0
setw -g pane-base-index 0

# Enable mouse support
set -g mouse on

# Reload tmux config with prefix + r
bind r source-file ~/.tmux.conf \; display-message "tmux config reloaded"

# message prompt 
set -g message-style 'fg=black,bg=yellow'
set -g pane-border-style 'fg=#000000'
set -g pane-active-border-style 'fg=#FF2EFF'
set -g pane-border-lines single 
set -g status-style 'fg=#800080'
set -g window-status-separator "    "
set -g window-status-format "(#I) #[fg=#800080][#W]"
set -g window-status-current-format "(#I) #[fg=#66b2b2][#W] "
set -g status-left ""
set -g status-right ""

