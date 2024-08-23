#!/bin/bash

echo "Would you like to install Bluetooth services? (y/n)"
read response

install_arch_bluetooth_services() {
    echo "Installing Bluetooth services..."
    paru -S --noconfirm bluez blueman

    # Enable Bluetooth service
    sudo systemctl enable bluetooth
    echo "Bluetooth services installed and enabled."
}

install_debian_bluetooth_services() {
    echo "Using nala to install Bluetooth services..."
    sudo nala install -y bluez blueman
    sudo systemctl enable bluetooth
    echo "Bluetooth services installed and enabled."
}

if [[ "$response" =~ ^[Yy]$ ]]; then
    echo "Installing Bluetooth services..."
    
    # Check if the system is Debian-based or Arch-based
    if [ -f /etc/debian_version ]; then
        install_debian_bluetooth_services
    elif [ -f /etc/arch-release ]; then
        install_arch_bluetooth_services
    else
        echo "Unsupported distribution. Exiting."
        exit 1
    fi

elif [[ "$response" =~ ^[Nn]$ ]]; then
    echo "Bluetooth services will not be installed."
else
    echo "Invalid input. Please enter 'y' or 'n'."
fi
