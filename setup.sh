#!/bin/bash

# Create a log file
LOG_FILE=~/dwm-install/install_log.txt

# Function to log messages
log_message() {
    echo "$(date): $1" >> "$LOG_FILE"
}

# Initialize log file
echo "Installation Log" > "$LOG_FILE"
log_message "Starting installation process"

# Function to update package list
update_package_list() {
    if command -v nala &> /dev/null; then
        sudo nala update
        log_message "Updated package list using nala"
    elif command -v pacman &> /dev/null; then
        sudo pacman -Sy --noconfirm
        log_message "Updated package list using pacman"
    else
        echo "No supported package manager found."
        log_message "No supported package manager found for updating package list"
    fi
}

# Function to install dialog
install_dialog() {
    log_message "Attempting to install dialog"
    if command -v apt &> /dev/null; then
        sudo apt install -y dialog
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm dialog
    else
        echo "No supported package manager found for installing dialog."
        log_message "Failed to install dialog"
        exit 1
    fi
    log_message "Dialog installed successfully"
}

# Install dialog if not already installed
if ! command -v dialog &> /dev/null; then
    install_dialog
fi

# Function to install Nala on Debian-based systems
install_nala() {
    log_message "Attempting to install Nala"
    echo "Detected a Debian-based system."
    if ! command -v nala &> /dev/null; then
        # echo "Nala is not installed. Attempting to install Nala..."
        dialog --title "Installing Nala" --infobox "Nala is not installed. Attempting to install Nala..." 5 50
        update_package_list
        sudo apt install -y nala
        if [ $? -ne 0 ]; then
            # echo "Nala installation failed. Falling back to apt."
            dialog --title "Nala Installation Failed" --msgbox "Nala installation failed. Falling back to apt." 6 50
            log_message "Nala installation failed, falling back to apt"
            return 1 
        fi
        log_message "Nala installed successfully"
    fi
    sudo nala fetch
    # echo "Nala setup complete."
    dialog --title "Nala Setup Complete" --msgbox "Nala setup complete." 5 30
    log_message "Nala setup completed"
}

# Function to install Git on Debian-based systems using Nala
install_git_debian() {
    log_message "Attempting to install Git using Nala"
    # echo "Attempting to install Git using Nala..."
    dialog --title "Installing Git" --infobox "Attempting to install Git using Nala..." 5 50
    update_package_list
    sudo nala install -y git
    log_message "Git installation completed (Debian)"
}

# Function to install Git on Arch-based systems
install_git_arch() {
    log_message "Attempting to install Git on Arch-based system"
    # echo "Detected an Arch-based system."
    # echo "Attempting to install Git..."
    dialog --title "Installing Git" --infobox "Detected an Arch-based system. Attempting to install Git..." 5 60

    # Use paru if available, fallback to pacman
    if command -v paru &> /dev/null; then
        paru -S --noconfirm git
        log_message "Git installed using paru"
    else
        # echo "Paru is not installed. Installing paru with pacman..."
        dialog --title "Installing Paru" --infobox "Paru is not installed. Installing paru with pacman..." 5 60
        log_message "Installing paru"
        sudo pacman -S --needed --noconfirm base-devel git
        git clone https://aur.archlinux.org/paru.git
        cd paru && makepkg -si --noconfirm
        cd .. && rm -rf paru

        # Retry Git installation with paru or fallback to pacman
        if command -v paru &> /dev/null; then
            paru -S --noconfirm git
            log_message "Git installed using paru (after paru installation)"
        else
            sudo pacman -S --noconfirm git
            log_message "Git installed using pacman"
        fi
    fi
}

# Check if Git is installed
if ! command -v git &> /dev/null; then
    log_message "Git not found, attempting to install"
    # echo "Git is not installed. Attempting to install Git..."
    dialog --title "Git Not Found" --infobox "Git is not installed. Attempting to install Git..." 5 50

    # Check the system type and call the appropriate installation function
    if command -v apt &> /dev/null; then
        if install_nala; then
            install_git_debian
        else
            # echo "Falling back to apt..."
            dialog --title "Falling Back to Apt" --infobox "Falling back to apt..." 5 30
            log_message "Falling back to apt for Git installation"
            update_package_list
            sudo apt install -y git
        fi
    elif command -v pacman &> /dev/null; then
        install_git_arch
    else
        # echo "Unsupported system. Please install Git manually and run this script again."
        dialog --title "Unsupported System" --msgbox "Unsupported system. Please install Git manually and run this script again." 7 50
        log_message "Unsupported system for Git installation"
        exit 1
    fi

    # Check if Git was successfully installed
    if ! command -v git &> /dev/null; then
        # echo "Git installation failed. Please install Git manually and run this script again."
        dialog --title "Git Installation Failed" --msgbox "Git installation failed. Please install Git manually and run this script again." 7 60
        log_message "Git installation failed"
        exit 1
    fi
fi

log_message "Git is installed"
# echo "Git is installed. Continuing with the script..."
dialog --title "Git Installed" --msgbox "Git is installed. Continuing with the script..." 5 50

# Clone repositories
git clone https://github.com/sevu11/dwm-install ~/dwm-install
log_message "Cloned dwm-install repository"

clear

# echo "
dialog --title "DWM Install Script" --msgbox "
 █████  ██████   ██████ ██   ██                                                                                                                  
██   ██ ██   ██ ██      ██   ██                                                                                                                  
███████ ██████  ██      ███████                                                                                                                  
██   ██ ██   ██ ██      ██   ██                                                                                                                  
██   ██ ██   ██  ██████ ██   ██                                                                                                                  
                                                                                                                                                 
                                                                                                                                                 
██████  ███████ ██████  ██  █████  ███    ██                                                                                                     
██   ██ ██      ██   ██ ██ ██   ██ ████   ██                                                                                                     
██   ██ █████   ██████  ██ ███████ ██ ██  ██                                                                                                     
██   ██ ██      ██   ██ ██ ██   ██ ██  ██ ██                                                                                                     
██████  ███████ ██████  ██ ██   ██ ██   ████                                                                                                     
                                                                                                                                                 
                                                                                                                                                 
          ██████  ██     ██ ███    ███     ██ ███    ██ ███████ ████████  █████  ██      ██          ███████  ██████ ██████  ██ ██████  ████████ 
          ██   ██ ██     ██ ████  ████     ██ ████   ██ ██         ██    ██   ██ ██      ██          ██      ██      ██   ██ ██ ██   ██    ██    
█████     ██   ██ ██  █  ██ ██ ████ ██     ██ ██ ██  ██ ███████    ██    ███████ ██      ██          ███████ ██      ██████  ██ ██████     ██    
          ██   ██ ██ ███ ██ ██  ██  ██     ██ ██  ██ ██      ██    ██    ██   ██ ██      ██               ██ ██      ██   ██ ██ ██         ██    
          ██████   ███ ███  ██      ██     ██ ██   ████ ███████    ██    ██   ██ ███████ ███████     ███████  ██████ ██   ██ ██ ██         ██    
                                                                                                                                                 
" 25 100

# Function to install LTS kernel for Debian-based systems
install_lts_kernel_debian() {
    log_message "Attempting to install LTS kernel for Debian-based system"
    # echo "Installing LTS kernel for Debian-based system..."
    dialog --title "Installing LTS Kernel" --infobox "Installing LTS kernel for Debian-based system..." 5 60
    update_package_list
    sudo nala install -y linux-image-amd64
    if [ $? -eq 0 ]; then
        # echo "LTS kernel installed successfully."
        dialog --title "LTS Kernel Installed" --msgbox "LTS kernel installed successfully." 5 40
        log_message "LTS kernel installed successfully (Debian)"
    else
        # echo "Failed to install LTS kernel."
        dialog --title "LTS Kernel Installation Failed" --msgbox "Failed to install LTS kernel." 5 40
        log_message "Failed to install LTS kernel (Debian)"
    fi
}

# Function to install LTS kernel for Arch-based systems
install_lts_kernel_arch() {
    log_message "Attempting to install LTS kernel for Arch-based system"
    # echo "Installing LTS kernel for Arch-based system..."
    dialog --title "Installing LTS Kernel" --infobox "Installing LTS kernel for Arch-based system..." 5 60
    update_package_list
    sudo pacman -S --noconfirm linux-lts linux-lts-headers
    if [ $? -eq 0 ]; then
        # echo "LTS kernel installed successfully."
        # echo "Updating GRUB..."
        dialog --title "LTS Kernel Installed" --msgbox "LTS kernel installed successfully. Updating GRUB..." 6 50
        sudo grub-mkconfig -o /boot/grub/grub.cfg
        log_message "LTS kernel installed successfully and GRUB updated (Arch)"
    else
        # echo "Failed to install LTS kernel."
        dialog --title "LTS Kernel Installation Failed" --msgbox "Failed to install LTS kernel." 5 40
        log_message "Failed to install LTS kernel (Arch)"
    fi
}

# Prompt user for LTS kernel installation
# echo "Would you like to install the LTS kernel? (y/n)"
# read response
if dialog --title "Install LTS Kernel" --yesno "Would you like to install the LTS kernel?" 7 50; then
    clear
    # echo "Installing LTS kernel..."
    log_message "User chose to install LTS kernel"
    
    # Determine the distribution and install LTS kernel
    if [ -f /etc/debian_version ]; then
        install_lts_kernel_debian
    elif [ -f /etc/arch-release ]; then
        install_lts_kernel_arch
    else
        # echo "Unsupported distribution. Skipping LTS kernel installation."
        dialog --title "Unsupported Distribution" --msgbox "Unsupported distribution. Skipping LTS kernel installation." 6 50
        log_message "Unsupported distribution for LTS kernel installation"
    fi
# elif [[ "$response" =~ ^[Nn]$ ]]; then
#     echo "LTS kernel will not be installed."
else
    dialog --title "LTS Kernel Installation" --msgbox "LTS kernel will not be installed." 5 40
    log_message "User chose not to install LTS kernel"
# else
#     echo "Invalid input. Please enter 'y' or 'n'."
#     log_message "Invalid input for LTS kernel installation"
fi

clear

# Function to install and configure LightDM
install_lightdm() {
    log_message "Installing LightDM"
    # echo "Installing LightDM..."
    dialog --title "Installing LightDM" --infobox "Installing LightDM..." 5 30
    update_package_list
    if [ -f /etc/debian_version ]; then
        sudo nala install -y lightdm lightdm-gtk-greeter
    elif [ -f /etc/arch-release ]; then
        sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter
    fi
    sudo systemctl enable lightdm.service
    # echo "LightDM installed and enabled."
    dialog --title "LightDM Installed" --msgbox "LightDM installed and enabled." 5 40
    log_message "LightDM installed and enabled"
}

# Function to install and configure SDDM
install_sddm() {
    log_message "Installing SDDM"
    # echo "Installing SDDM..."
    dialog --title "Installing SDDM" --infobox "Installing SDDM..." 5 30
    update_package_list
    if [ -f /etc/debian_version ]; then
        sudo nala install -y sddm
    elif [ -f /etc/arch-release ]; then
        sudo pacman -S --noconfirm sddm
    fi
    sudo systemctl enable sddm.service
    # echo "SDDM installed and enabled."
    dialog --title "SDDM Installed" --msgbox "SDDM installed and enabled." 5 40
    log_message "SDDM installed and enabled"
}

# Prompt user for display manager installation
# echo "Would you like to install a display manager? (recommended) (y/n)"
# read dm_response
if dialog --title "Install Display Manager" --yesno "Would you like to install a display manager? (recommended)" 7 60; then
    # echo "Choose a display manager to install:"
    # echo "1. LightDM"
    # echo "2. SDDM"
    # read -p "Enter your choice (1 or 2): " dm_choice
    dm_choice=$(dialog --title "Choose Display Manager" --menu "Choose a display manager to install:" 10 50 2 \
        1 "LightDM" \
        2 "SDDM" \
        3>&1 1>&2 2>&3)

    case $dm_choice in
        1)
            install_lightdm
            log_message "User chose to install LightDM"
            ;;
        2)
            install_sddm
            log_message "User chose to install SDDM"
            ;;
        *)
            # echo "Invalid choice. No display manager will be installed."
            echo "Invalid choice. No display manager will be installed."
            log_message "Invalid choice for display manager, none installed"
            ;;
    esac
elif [[ "$dm_response" =~ ^[Nn]$ ]]; then
    echo "No display manager will be installed."
    log_message "User chose not to install a display manager"
else
    echo "Invalid input. No display manager will be installed."
    log_message "Invalid input for display manager installation"
fi

clear

# Check if SDDM was installed
if systemctl is-enabled sddm.service &> /dev/null; then
    echo "SDDM was installed. Copying theme..."
    log_message "Copying SDDM theme"
    sudo mkdir -p /usr/share/sddm/themes/chili
    sudo cp -r ~/dwm-install/.config/sddm/themes/chili /usr/share/sddm/themes/
    if [ $? -eq 0 ]; then
        echo "SDDM theme 'chili' successfully copied to /usr/share/sddm/themes/"
        log_message "SDDM theme 'chili' successfully copied"
    else
        echo "Failed to copy SDDM theme. Please check permissions and try again."
        log_message "Failed to copy SDDM theme"
    fi
else
    echo "SDDM is not installed. Skipping theme installation."
    log_message "SDDM not installed, skipped theme installation"
fi

# Run the setup script
log_message "Running setup script"
bash ~/dwm-install/scripts/setup.sh

clear

# Run the extra packages script
log_message "Running extra packages script"
bash ~/dwm-install/scripts/packages.sh

clear

# Install printer services
log_message "Installing printer services"
bash ~/dwm-install/scripts/printers.sh

# Install Bluetooth services
log_message "Installing Bluetooth services"
bash ~/dwm-install/scripts/bluetooth.sh

# Clean up packages on Debian-based systems
if command -v apt &> /dev/null; then
    log_message "Cleaning up packages (Debian)"
    sudo nala autoremove -y

# Clean up packages on Arch-based systems
elif command -v pacman &> /dev/null; then
    log_message "Cleaning up packages (Arch)"
    sudo pacman -Rns $(pacman -Qdtq) --noconfirm
fi

clear

# Prompt user to remove repo folders
echo "Do you want to remove the dwm-install repository folder? (y/n)"
read remove_repos

if [[ "$remove_repos" =~ ^[Yy]$ ]]; then
    echo "Removing dwm-install repository folder..."
    rm -rf ~/dwm-install
    echo "The dwm-install repository folder has been removed."
elif [[ "$remove_repos" =~ ^[Nn]$ ]]; then
    echo "The dwm-install repository folder will be kept."
else
    echo "Invalid input. The dwm-install repository folder will be kept."
fi

clear

printf "\e[1;32mYou can now reboot! Thank you.\e[0m\n"