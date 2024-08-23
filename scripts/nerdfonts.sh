#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install unzip for Debian-based systems
install_unzip_debian() {
    echo "Installing unzip using nala..."
    sudo nala update
    sudo nala install unzip -y
}

# Function to install unzip for Arch-based systems
install_unzip_arch() {
    echo "Installing unzip for Arch-based system..."
    echo "Using paru to install unzip..."
    paru -S --noconfirm unzip
}

# Determine the distribution and install unzip if necessary
if ! command_exists unzip; then
    echo "Unzip is not installed. Installing..."
    
    if [ -f /etc/debian_version ]; then
        install_unzip_debian
    elif [ -f /etc/arch-release ]; then
        install_unzip_arch
    else
        echo "Unsupported distribution. Exiting."
        exit 1
    fi
fi

# Create directory for fonts if it doesn't exist
mkdir -p ~/.local/share/fonts

# Array of font names
fonts=( 
    "CascadiaCode"
    "FiraCode"  
    "Hack"  
    "Inconsolata"
    "JetBrainsMono" 
    "Meslo"
    "Mononoki" 
    "RobotoMono" 
    "SourceCodePro" 
    "UbuntuMono"
)

# Function to check if font directory exists
check_font_installed() {
    local font_name=$1
    if [ -d ~/.local/share/fonts/$font_name ]; then
        echo "Font $font_name is already installed. Skipping."
        return 0  # Font already installed
    else
        return 1  # Font not installed
    fi
}

# Loop through each font, check if installed, and install if not
for font in "${fonts[@]}"
do
    if check_font_installed "$font"; then
        echo "Skipping installation of font: $font"
        continue  # Skip installation if font is already installed
    fi
    
    echo "Installing font: $font"
    wget -q --show-progress "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/$font.zip" -P /tmp
    if [ $? -ne 0 ]; then
        echo "Failed to download font: $font"
        continue
    fi
    
    unzip -q /tmp/$font.zip -d ~/.local/share/fonts/$font/
    if [ $? -ne 0 ]; then
        echo "Failed to extract font: $font"
        continue
    fi
    
    rm /tmp/$font.zip
done

# Update font cache
fc-cache -f

echo "Fonts installation completed."
