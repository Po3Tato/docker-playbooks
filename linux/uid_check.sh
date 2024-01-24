#!/bin/bash

# Function to list users with root privileges
list_users() {
    echo "Users with root privileges:"
    grep '^sudo:' /etc/group | cut -d: -f4 | tr ',' '\n'
}

# Function to change the password for a user
change_password() {
    local attempts=0
    local max_attempts=3

    while [ $attempts -lt $max_attempts ]; do
        read -p "Enter the username to change the password: " username
        if id "$username" &>/dev/null; then
            if [ "$username" != "root" ]; then
                sudo passwd "$username"
                echo "Password changed successfully for $username"
                return 0
            else
                echo "Error: Changing the password for the root user is not allowed. Please try again."
            fi
        else
            attempts=$((attempts + 1))
            if [ $attempts -lt $max_attempts ]; then
                echo "Error: $username is not a valid user. You have $((max_attempts - attempts)) attempts remaining. Please try again."
            else
                echo "Maximum attempts reached. Exiting function."
                return 1
            fi
        fi
    done
}

# Main script
read -p "This script will list users with root privileges and allow you to change the password for a selected user. Continue? (y/n): " confirmation

if [ "$confirmation" != "y" ]; then
    echo "Exiting script."
    exit 0
fi

list_users
change_password
