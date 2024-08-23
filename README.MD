# DWM Installation and Configuration Scripts

This repository contains a collection of scripts to automate the installation and configuration of DWM (Dynamic Window Manager) along with various utilities and applications. These scripts are designed to work on both Debian-based and Arch-based Linux distributions.

## Features

- Automated installation of DWM and related components
- Installation of various utilities and applications
- Support for both Debian-based and Arch-based systems
- Customizable package selection

## Main Components

1. **setup.sh**: The main setup script that orchestrates the installation process.
2. **install.sh**: Handles the installation of core packages and DWM.
3. **packages.sh**: Allows users to select and install additional packages.
4. **nerdfonts.sh**: Installs a selection of Nerd Fonts.
5. **picom.sh**: Installs and configures the Picom compositor.
6. **bluetooth.sh**: Installs and configures Bluetooth services.
7. **printers.sh**: Installs and configures printing services.

## Usage

1. Clone this repository to your local machine.
2. Make the scripts executable: `chmod +x *.sh`
3. Run the main setup script: `./setup.sh`
4. Follow the on-screen prompts to customize your installation.

## Requirements

- A Debian-based (e.g., Ubuntu, Linux Mint) or Arch-based (e.g., Arch Linux, Manjaro) Linux distribution
- Internet connection for downloading packages and components

## Note

Please review the scripts before running them to ensure they meet your needs and expectations. Some scripts may require root privileges to install system packages.

## Credits

This project was inspired by the work of [Drew Griffin](https://github.com/drewgrif). We appreciate his contributions to the Linux community and the inspiration provided for these scripts.

