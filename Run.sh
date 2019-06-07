#!/bin/bash

PATH=/usr/local/bin:$PATH
echo $PATH

# ================
# Install Prereqs
# ================

function validateProgramIsInstalled () {
	local command=${1}
	local appName=${2}
    local exitOnFailure=${3}

    echo "Validating ${appName} install..."

	if command -v "$command" >/dev/null; then
		printf "$appName is installed!\n\n"
		true;
	elif "$exitOnFailure"; then
		echo "${appName} install failed? :(";
		exit 1;
	else
		echo "${command} not detected on PATH"
		false;
	fi
}

function validateBrewInstall () {
	local command=${1}
	local appName=${2:-$1}

    if !(validateProgramIsInstalled "$command" "$appName" false); then
		echo >&2 "Attempting to install $appName...";
		brew install "$command";
		validateProgramIsInstalled "$command" "$appName" true
	fi
}

# --------
# Homebrew
# --------

if !(validateProgramIsInstalled "brew" "Homebrew" false); then
	echo "Homebrew not installed :/ Run install_brew.command";
fi

# ------
# Python
# ------
validateBrewInstall "python3" "Python 3"

# ------
# Pip3
# ------
validateBrewInstall "pip3"

# ------
# libusb
# ------
echo "Validating libusb install..."

if !(brew ls --versions libusb > /dev/null); then
	echo "Installing libusb..."
	brew install libusb;
fi

printf "libusb is installed!\n\n"

# ----------
# pipenv
# ----------
validateBrewInstall "pipenv"

# ==========================================
# Setting up virtual environemnt for program
# ==========================================

# pipenv --three;
pipenv install -r requirements.txt;

# ===============================================
# Run the program within the virtual environment!
# ===============================================

echo "Currently running software!"
pipenv run python3 -u JoeyJoebags336.py;
echo "Software has closed"
exit 0;

# TODO read-only issues. May need to create env somewhere else
