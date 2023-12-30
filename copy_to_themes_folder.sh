#!/bin/bash

# **Make sure this script is in the root dir of the theme, or change its target if you change its dir**
# If throws some permission message, make sure the file is executable. And don't just try to sudo it.

# Specify the default terminal emulator
terminal_cmd=${TERMINAL_EMULATOR:-konsole}

# Check if the script is NOT running in a terminal
if [ ! -t 0 ]; then
    # Check if the specified terminal emulator command is available
    if command -v "$terminal_cmd" &> /dev/null; then
        # Launch the script in the selected terminal emulator
        "$terminal_cmd" -e "$0"
        exit 0
    else
        # Display an error if the terminal emulator is not found
        echo "Error: Specified terminal emulator '$terminal_cmd' not found."
        exit 1
    fi
fi

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    # Prompt for root password using sudo
    sudo "$0" "$@"
    exit $?
fi

# Get source dir
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define destination folder
destination_folder="/usr/share/sddm/themes/"

# Get the base name of the script's directory
theme_name=$(basename "$script_dir")

# Check if the destination folder already exists
if [ -d "$destination_folder$theme_name" ]; then
    # Confirm before proceeding with removal and copy
    read -p "The destination folder '$destination_folder$theme_name' already exists. Do you want to remove it and copy the new theme? (y/n): " choice

    if [ "$choice" == "y" ]; then
        # Remove the existing destination folder and its contents
        sudo rm -rf "$destination_folder$theme_name"
        echo "Existing '$theme_name' theme removed."

        # Copy the theme to the destination folder
        sudo cp -r "$script_dir" "$destination_folder"
        echo "'$theme_name' theme copied successfully to '$destination_folder'."
    else
        echo "Operation canceled."
    fi
else
    # Copy the theme to the destination folder by default
    sudo cp -r "$script_dir" "$destination_folder"
    echo "'$theme_name' theme copied successfully to '$destination_folder'."
fi
