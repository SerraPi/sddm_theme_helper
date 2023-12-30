#!/bin/bash

# **Make sure this script is in the root dir of the theme, or change its target if you change the dir**
# If thros some permission message, make sure the file is executable. And dont just try to sudo it.

# Get dir
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run SDDM greeter in test mode
sddm-greeter --test-mode --theme "$script_dir"
