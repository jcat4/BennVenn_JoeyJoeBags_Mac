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
	echo "Attempting to install Homebrew...";
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
	validateProgramIsInstalled "brew" "Homebrew" true
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
brew install libusb; # TODO figure out way to see if installed, since it's not on path?
printf "libusb is installed!\n\n"

# ----------
# VirtualEnv
# ----------
validateBrewInstall "virtualenv"

# ----------
# pipenv
# ----------
validateBrewInstall "pipenv"

# ==========================================
# Setting up virtual environemnt for program
# ==========================================

# Todo just fetch environment instead of creating if it exists?
pipenv --three;
# pipenv install -r requirements.txt; # TODO doesn't work
# pipenv install pyusb; # todo this also isn't working
# pipenv run pip3 install pyusb; # welp, this works :/ No locks with this, tho. OH WELL.
pipenv run pip3 install -r requirements.txt; # this works a lil better, still no locking


# ===============================================
# Run the program within the virtual environment!
# ===============================================

echo "Currently running software!"
pipenv run python3 -u JoeyJoebags336.py;
echo "Software has closed"
exit 0;

# TODO if python terminates, terminate shell script (and app)
# TODO flashing that huge ROM isn't working. Is there not enough space or something?