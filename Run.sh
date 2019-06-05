# ================
# Install Prereqs
# ================

function validateProgramIsInstalled () {
	local command=${1}
	local appName=${2}
    local exitOnFailure=${3}

    echo "Validating ${appName} install..."

	if command -v "$command" >/dev/null 2>&1; then
		printf "$appName is installed!\n\n"
		true;
	elif "$exitOnFailure"; then
		echo >&2 "${appName} install failed? :(";
		exit 1;
	else
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
echo "Validating Homebrew install..."

if !(validateProgramIsInstalled "brew" "Homebrew" false); then
	echo >&2 "Attempting to install Homebrew...";
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

echo "Starting JoeyJoeBags software..."
pipenv run python3 JoeyJoebags336.py;
