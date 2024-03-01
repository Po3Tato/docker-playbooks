#
function prompt_user() {
    read -p "Do you want to install $1? (Y/n): " choice
    case $choice in
        Y|y) return 0 ;;
        N|n) return 1 ;;
        *) echo "Invalid input. Please enter 'Y' or 'N'." >&2 ; exit 1;;
    esac
}

function progress_bar() {
    local width=50
    local done=$((width * $1 / 100))
    printf "\rProgress: ["; for ((i = 0; i < width; i++)); do echo -n " "; 
done; printf "] $(($1 * 2))%"; sleep 0.1;
}

function install_app() {
    if ! dpkg -s $1 &> /dev/null; then
        if prompt_user "$2"; then
            echo "Installing $2..."
            sudo apt install -y --show-progress $1 & progress_bar $(echo $! | 
awk '{print int($1/3)}')
        else
            echo "Skipping $2."
        fi
    else
        echo "$2 is already installed."
    fi
}

install_app htop "htop"
install_app iftop "iftop"
install_app neofetch "neofetch"
