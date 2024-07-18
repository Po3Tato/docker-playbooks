#!/usr/bin/env bash

set -e

# check for sudo/root
check_sudo() {
    if [ "$EUID" -ne 0 ]; then
        echo "Please run script as root."
        exit 1
    fi
}

# function to install Ollama binary
install_ollama() {
    echo "Downloading Ollama binary..."
    curl -L https://ollama.com/download/ollama-linux-amd64 -o /usr/bin/ollama
    chmod +x /usr/bin/ollama
    echo "Ollama binary installed successfully."
}

# create Ollama user
create_ollama_user() {
    echo "Creating Ollama user..."
    useradd -r -s /bin/false -m -d /usr/share/ollama ollama
    echo "Ollama user created successfully."
}

# configure Ollama service
create_ollama_service() {
    echo "Creating Ollama service file..."
    cat << EOF > /etc/systemd/system/ollama.service
[Unit]
Description=Ollama Service
After=network-online.target

[Service]
ExecStart=/usr/bin/ollama serve
User=ollama
Group=ollama
Restart=always
RestartSec=3

[Install]
WantedBy=default.target
EOF
    echo "Ollama service file created successfully."
}

# enable and start Ollama service
enable_ollama_service() {
    echo "Enabling and starting Ollama service..."
    systemctl daemon-reload
    systemctl enable ollama
    systemctl start ollama
    echo "Ollama service enabled and started successfully."
}

main() {
    check_sudo
    install_ollama
    create_ollama_user
    create_ollama_service
    enable_ollama_service
    echo "Ollama installation completed successfully!"
}

# Run the main function
main
