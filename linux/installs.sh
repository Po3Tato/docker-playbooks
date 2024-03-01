####################################################################
### I always install the same apps for every vm i create.        ###
### I will like this script to run once the vm has been deployed. ##
# user prompts
function prompt_user() {
    read -p "Do you want to install $1? (Y/n): " choice
    case $choice in
        Y|y) return 0 ;;
        N|n) return 1 ;;
        *) echo "Invalid input. Please enter 'Y' or 'N'." >&2 ; exit 1;;
    esac
}
function install_app() {
    if ! dpkg -s $1 &> /dev/null; then
        if prompt_user "$2"; then
            echo "Installing $2..."
            sudo apt install -y --show-progress $1
        else
            echo "Skipping $2."
        fi
    else
        echo "$2 is already installed."
    fi
}
# apps
install_app htop "htop"
install_app iftop "iftop"
install_app neofetch "neofetch"
