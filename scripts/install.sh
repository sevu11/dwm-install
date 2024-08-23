#!/bin/bash

# Function to check and rename ~/.config/suckless if it exists
check_and_rename_suckless_dir() {
    local suckless_dir="$HOME/.config/suckless"
    local backup_dir="$HOME/.config/suckless.orig"

    if [ -d "$suckless_dir" ]; then
        echo "Found existing $suckless_dir directory. Renaming to $backup_dir."
        mv "$suckless_dir" "$backup_dir"
        if [ $? -ne 0 ]; then
            echo "Failed to rename $suckless_dir to $backup_dir. Exiting."
            exit 1
        fi
    fi
}

# Call function to check and rename ~/.config/suckless if necessary
check_and_rename_suckless_dir

# Main list of packages
packages=(
    "xorg-dev"
    "sxhkd"
    "firefox-esr"
    "tilix"
    "kitty"
    "flameshot"
    "ranger"
)

# Function to read common packages from a file
read_common_packages() {
    local common_file="$1"
    if [ -f "$common_file" ]; then
        packages+=( $(< "$common_file") )
    else
        echo "Common packages file not found: $common_file"
        exit 1
    fi
}

# Read common packages from file
read_common_packages "$HOME/dwm-install/scripts/common_packages.txt"

# Function to install packages on Debian-based systems
install_packages_debian() {
    local pkgs=("$@")
    local missing_pkgs=()

    # Check if each package is installed
    for pkg in "${pkgs[@]}"; do
        if ! dpkg -l | grep -q " $pkg "; then
            missing_pkgs+=("$pkg")
        fi
    done

    # Install missing packages
    if [ ${#missing_pkgs[@]} -gt 0 ]; then
        echo "Installing missing packages: ${missing_pkgs[@]}"
        sudo nala update
        sudo nala install -y "${missing_pkgs[@]}"
        if [ $? -ne 0 ]; then
            echo "Failed to install some packages. Exiting."
            exit 1
        fi
    else
        echo "All required packages are already installed."
    fi
}

# Function to install packages on Arch-based systems using paru
install_packages_arch() {
    local pkgs=("$@")
    local missing_pkgs=()

    # Check if each package is installed
    for pkg in "${pkgs[@]}"; do
        if ! pacman -Qi "$pkg" &> /dev/null; then
            missing_pkgs+=("$pkg")
        fi
    done

    # Install missing packages
    if [ ${#missing_pkgs[@]} -gt 0 ]; then
        echo "Installing missing packages: ${missing_pkgs[@]}"
        paru -S --noconfirm "${missing_pkgs[@]}"
        if [ $? -ne 0 ]; then
            echo "Failed to install some packages. Exiting."
            exit 1
        fi
    else
        echo "All required packages are already installed."
    fi
}

# Determine the package manager and install packages accordingly
if [ -f /etc/debian_version ]; then
    install_packages_debian "${packages[@]}"
elif [ -f /etc/arch-release ]; then
    install_packages_arch "${packages[@]}"
else
    echo "Unsupported distribution. Exiting."
    exit 1
fi

# Enable services
sudo systemctl enable avahi-daemon
sudo systemctl enable acpid

# Update user directories
xdg-user-dirs-update
mkdir -p ~/Screenshots/

# Ensure /usr/share/xsessions directory exists
if [ ! -d /usr/share/xsessions ]; then
    sudo mkdir -p /usr/share/xsessions
    if [ $? -ne 0 ]; then
        echo "Failed to create /usr/share/xsessions directory. Exiting."
        exit 1
    fi
fi

# Write dwm.desktop file
cat > ./temp << "EOF"
[Desktop Entry]
Encoding=UTF-8
Name=dwm
Comment=Dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession
EOF
sudo cp ./temp /usr/share/xsessions/dwm.desktop
rm ./temp

# Copy configuration files from ~/dwm-install/.config/suckless to ~/.config/suckless
mkdir -p "$HOME/.config/suckless"
cp -r "$HOME/dwm-install/.config/suckless/"* "$HOME/.config/suckless/"
if [ $? -ne 0 ]; then
    echo "Failed to copy configuration files. Exiting."
    exit 1
fi

# Install custom dwm
cd ~/.config/suckless/dwm
make
sudo make clean install

# Install custom slstatus
cd ~/.config/suckless/slstatus
make
sudo make clean install

# Install custom st
cd ~/.config/suckless/st
make
sudo make clean install

# Install additional scripts and themes
bash ~/dwm-install/scripts/picom.sh
bash ~/dwm-install/scripts/nerdfonts.sh