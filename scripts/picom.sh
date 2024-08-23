#!/bin/bash

# Check if picom is already installed
if picom --version >/dev/null 2>&1; then
    echo "Picom is already installed. Skipping installation."
    exit 0
fi

# If picom is not installed, proceed with installation steps
echo "Picom is not installed. Installing..."

# Function to install dependencies on Arch using paru
install_arch_dependencies() {
    local dependencies=("$@")
    echo "Using paru to install dependencies..."
    paru -S --noconfirm "${dependencies[@]}"
}

# Check if the system is Debian-based or Arch-based
if [ -f /etc/debian_version ]; then
    echo "Detected Debian-based system. Installing dependencies using nala..."

    # Update and install necessary dependencies for Debian-based systems
    sudo nala update
    sudo nala install -y libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev \
                        libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev \
                        libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev \
                        libxcb-dpms0-dev libxcb-glx0-dev libxcb-image0-dev \
                        libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev \
                        libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev \
                        libxcb-xfixes0-dev libxext-dev meson ninja-build uthash-dev

elif [ -f /etc/arch-release ]; then
    echo "Detected Arch-based system. Installing dependencies..."

    # Define necessary dependencies for Arch
    arch_dependencies=(
        meson
        ninja
        uthash
        libev
        libconfig
        dbus
        libgl
        libepoxy
        pcre2
        pixman
        libx11
        libxcb
        xcb-util
        xcb-util-renderutil
        xcb-util-wm
        xcb-util-image
        xcb-util-keysyms
        xcb-util-xrm
        xcb-util-cursor
        xorg-xrandr
        libxext
    )

    # Install dependencies on Arch
    install_arch_dependencies "${arch_dependencies[@]}"

else
    echo "Unsupported distribution. Exiting."
    exit 1
fi

# Clone and build Picom from the FT-Labs repository
echo "Cloning Picom repository and building from source..."
git clone https://github.com/FT-Labs/picom ~/dwm-install/picom
cd ~/dwm-install/picom
meson setup --buildtype=release build
ninja -C build
sudo ninja -C build install

echo "Picom installation complete."

# Remove the cloned repository
echo "Cleaning up..."
cd ~
rm -rf ~/dwm-install/picom

echo "Picom installation and cleanup complete."

