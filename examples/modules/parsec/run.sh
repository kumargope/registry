#!/usr/bin/env bash

# Detect OS
OS=$(uname -s)
LOG_PATH="/tmp/parsec_install.log"

echo "Starting Parsec installation for $OS..." > "$LOG_PATH"

if [[ "$OS" == "Linux" ]]; then
    echo "Installing Parsec for Linux (Ubuntu/Debian)..." >> "$LOG_PATH"
    
    # Download and check if curl succeeded
    if curl -L "https://builds.parsec.app/package/parsec-linux.deb" -o "/tmp/parsec.deb"; then
        sudo apt-get update
        # Install dependencies
        sudo apt-get install -y libgl1-mesa-dri libgl1-mesa-glx libpulseaudio0
        # Install package and fix broken dependencies if any
        if sudo dpkg -i "/tmp/parsec.deb" || sudo apt-get install -f -y; then
            echo "Successfully installed Parsec on Linux" >> "$LOG_PATH"
        else
            echo "Error: Failed to install Parsec package" >> "$LOG_PATH"
        fi
        rm "/tmp/parsec.deb"
    else
        echo "Error: Failed to download Parsec for Linux" >> "$LOG_PATH"
    fi

elif [[ "$OS" == *"NT"* || "$OS" == *"MINGW"* ]]; then
    echo "Installing Parsec for Windows..." >> "$LOG_PATH"
    
    # Using PowerShell for silent installation
    if powershell.exe -Command "Invoke-WebRequest -Uri 'https://builds.parsec.app/package/parsec-windows.exe' -OutFile '\$env:TEMP\parsec.exe'"; then
        powershell.exe -Command "Start-Process '\$env:TEMP\parsec.exe' -ArgumentList '/S' -Wait"
        echo "Successfully installed Parsec on Windows" >> "$LOG_PATH"
    else
        echo "Error: Failed to download Parsec for Windows" >> "$LOG_PATH"
    fi
else
    echo "Error: Unsupported OS $OS" >> "$LOG_PATH"
    exit 1
fi