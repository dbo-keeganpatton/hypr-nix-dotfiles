#!/bin/bash

# Define options as a single string, separated by newlines
OPTIONS="Shutdown\nReboot\nSuspend\nHibernate\nLogout"

# Use wofi to present the options and get the user's choice
SELECTED=$(echo -e "$OPTIONS" | rofi -dmenu --prompt "Power Menu")

# Act on the user's choice
case "$SELECTED" in
  "Shutdown")
    shutdown now
    ;;
  "Reboot")
    reboot
    ;;
  "Suspend")
    systemctl suspend
    ;;
  "Hibernate")
    systemctl hibernate
    ;;
  "Logout")
    # This command is for Hyprland. 
    # If you use a different compositor, change this line.
    hyprctl dispatch exit
    ;;
esac
