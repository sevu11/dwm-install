#!/bin/bash

# Function to install printing services on Debian-based systems
install_printing_services_debian() {
    echo "Installing printing services using nala..."
    sudo nala update
    sudo nala install -y cups system-config-printer simple-scan
    sudo systemctl enable cups.service
    echo "Printing services installed and enabled."
}

# Function to install printing services on Arch-based systems
install_printing_services_arch() {
    echo "Installing printing services for Arch-based system..."
    echo "Using paru to install printing services..."
    paru -S --noconfirm cups system-config-printer simple-scan

    # Enable CUPS service
    sudo systemctl enable cups.service
    echo "Printing services installed and enabled."
}

# Ask the user if they want to install printing services
echo "Would you like to install printing services? (y/n)"
read response

# Handle the user's response
if [[ "$response" =~ ^[Yy]$ ]]; then
    echo "Installing printing services..."
    
    # Check if the system is Debian-based or Arch-based
    if [ -f /etc/debian_version ]; then
        install_printing_services_debian
    elif [ -f /etc/arch-release ]; then
        install_printing_services_arch
    else
        echo "Unsupported distribution. Exiting."
        exit 1
    fi

elif [[ "$response" =~ ^[Nn]$ ]]; then
    echo "Printing services will not be installed."
else
    echo "Invalid input. Please enter 'y' or 'n'."
fi