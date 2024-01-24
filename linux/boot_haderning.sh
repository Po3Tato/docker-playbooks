#!/bin/bash

# Function to print red and bold text
function print_red_bold {
    echo -e "\e[1;31m$1\e[0m"
}

# Prompt user before executing the script
print_red_bold "Do you want to run the script? (y/n): "
read answer
if [ "$answer" != "y" ]; then
    print_red_bold "Script execution aborted."
    exit 0
fi

# Function to print green and bold text
function print_green_bold {
    echo -e "\e[1;32m$1\e[0m"
}

# Lock the Boot Directory
print_green_bold "Locking the Boot Directory..."
# Open fstab file
nano /etc/fstab
# Set owner for fstab
chown root:root /etc/fstab

# Secure Boot Settings
print_green_bold "Securing Boot Settings..."
# Set owner and group of /etc/grub.conf
chown root:root /etc/grub.conf
# Set permissions on /etc/grub.conf
chmod og-rwx /etc/grub.conf

# Require authentication for single-user mode
sed -i "/SINGLE/s/sushell/sulogin/" /etc/sysconfig/init
sed -i "/PROMPT/s/yes/no/" /etc/sysconfig/init

print_red_bold "Script execution complete."
