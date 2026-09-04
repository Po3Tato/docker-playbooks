#!/usr/bin/env bash

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
    curl -L https://ollama.com/download/ollama-linux-amd64 -o /usr/bin/ollama || {
      echo "Failed to download Ollama binary."
      exit 1
    }
    chmod +x /usr/bin/ollama || {
      echo "Failed to set execute permission for Ollama binary."
      exit 1
    }
    echo "Ollama binary installed successfully."
}

# create Ollama user
create_ollama_user() {
    if id -u ollama &gt;&gt; /dev/null 2&gt;&amp;1; then
        echo "Ollama user already exists. Skipping creation..."
    else
        echo "Creating Ollama user..."
        useradd -r -s /bin/false -m -d /usr/share/ollama ollama || {
          echo "Failed to create Ollama user."
          exit 1
        }
        echo "Ollama user created successfully."
    fi
}

# configure Ollama service
create_ollama_service() {
    if [ ! -f /etc/systemd/system/ollama.service ]; then
        echo "Creating Ollama service file..."
        cat &gt; /etc/systemd/system/ollama.service &lt;&lt; EOF
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
    fi
}

# enable and start Ollama service
enable_ollama_service() {
    if systemctl is-enabled ollama &gt;&gt; /dev/null 2&gt;&amp;1; then
        echo "Ollama service already enabled. Skipping..."
    else
    echo "Enabling and starting Ollama service..."
        systemctl daemon-reload || {
          echo "Failed to reload systemd daemon."
          exit 1
}
        systemctl enable ollama || {
          echo "Failed to enable Ollama service."
          exit 1
        }
        systemctl start ollama || {
          echo "Failed to start Ollama service."
          exit 1
        }
        echo "Ollama service enabled and started successfully."
    fi
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
