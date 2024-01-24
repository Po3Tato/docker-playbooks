#!/bin/bash

# Function to print red and bold text
function print_red_bold {
    echo -e "\e[1;31m$1\e[0m"
}

# Function to print green and bold text
function print_green_bold {
    echo -e "\e[1;32m$1\e[0m"
}

# Function to create backups
function create_backup {
    if [ -e "$1" ]; then
        cp "$1" "$1_backup_$(date +"%Y%m%d%H%M%S")"
        print_green_bold "Backup created for $1."
    else
        print_red_bold "File $1 not found. Backup not created."
    fi
}

# Check if nano is installed
if ! command -v nano &> /dev/null; then
    # Nano is not installed, attempt to install it
    print_red_bold "nano is not installed. Attempting to install..."
    # Use the appropriate package manager for your system (e.g., apt, yum)
    sudo apt-get update
    sudo apt-get install -y nano
fi

# Prompt user before executing the script
print_red_bold "Do you want to run the script? (y/n): "
read answer
if [ "$answer" != "y" ]; then
    print_red_bold "Script execution aborted."
    exit 0
fi

# Lock the Boot Directory
print_green_bold "Locking the Boot Directory..."
# Create backup for fstab
create_backup "/etc/fstab"
# Open fstab file with nano
nano /etc/fstab
# Set owner for fstab with sudo
sudo chown root:root /etc/fstab

# ... (rest of the script)

print_red_bold "Script execution complete."
