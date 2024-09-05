#!/usr/bin/env bash
# Stop Ollama service
systemctl stop ollama || {
  echo "Failed to stop Ollama service."
  exit 1
}

# Reload nvidia_uvm
sudo rmmod nvidia_uvm && sudo modprobe nvidia_uvm || {
  echo "Failed to reload nvidia_uvm module."
  exit 1
}

# Restart Ollama service
systemctl start ollama || {
  echo "Failed to start Ollama service."
  exit 1
}
