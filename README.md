# Bennvenn's JoeyJoeBags Mac Port
This is a simple, "one-click-do-all" script to set up and run BennVenn's JoeyJoeBags software for his JoeyBoeBags ROM dumper on Mac OS.

### How to Use
**TL;DR** Simply navigate to the directory containing all of the code, and double click on the _Run.command_ file to launch the process. A new terminal window will open and start doing all the heavy lifting for you.

**Precaution**: It's _possible_ that Gatekeeper will not immediately allow you to run the command file. If that's the case, just follow the instructions on [this link](https://support.apple.com/kb/ph25088?locale=en_US) to open it anyway.

**Note**: If you do _not_ have Homebrew or the Xcode CLI tools installed on your machine, the terminal window will prompt you to enter your machine password to authorize those installs. Once Homebrew is installed, the script will continue general setup and eventually luanch the application.

This setup will only need to happen once. In the future, running the script will be _much_ quicker, as all it will need to do is validate that everything is in order before running the program.

Make sure that _Run.command_, _requirements.txt_, and _JoeyJoeBagsXXX.py_ are in the **same directory**, else the script will not work.

### What _exactly_ is this script doing?
**1. Install Homebrew**
Homebrew is a package manager for Mac OS that will be used to easily and reliably fetch up-to-date packages needed to run Ben's software on your machine.

Note, this will also install Xcode CLI tools on your machine, as Homebrew requires it to work.

**2. Install Python 3**
Ben's software is ultimately a set of Python scripts managed by a Python-driven interface. Of course, you'll need python to run it. :P

**3. Install pip3**
Pip is a "package manager" specifically for fetching python libraries for use by python scripts. We will need this to install any and all dependcies for running Ben's code.

**4. Install libusb**
Libusb is a library that allows various programs to interface with USB devices (read: the JoeyJoeBags device). Luckily for us Mac users, there's no need to worry about "driver signing" and whatnot like our Windows counterparts. We just need to install libusb, and we can interface with pretty much anything we want automatically. :)

**5. Install pipenv**
Pipenv is a tool that makes it easy to create and work inside of virtual environments for python. I do this so that I can guarantee that anything we need for running this program doesn't interfere with anything else on your system, or any other python apps you may run in the future. This is all especially necessary for anyone who tinkers with python development. All of the python dependencies installed by this script will only work within the created virtual environment, which is also where we will be running Ben's code.

**6. Create (or fetch an existing) Python Virtual Environment**
As mentioned above, we will be installing all dependencies and running Ben's code out of a virtual environment to ensure we're safely segregated from the rest of the system.

**7. Install python dependencies within virtual environment**
The script installs all dependencies required to run Ben's code in the VM based on a generated requirements file.

_I eventually plan on integrating that requirements generation in the script itself, for update functionality_

**8. Run the code!**
Pretty self explanitory. Just running Ben's python script out of the virtual environment.

### I don't trust you! Can I do this stuff myself?
Sure! Assuming you know how to use terminal and whatnot, just do the following:
1. Install Python 3
2. Install pip3
3. Install libusb
4. Use pip3 to install everything in the requirments.txt file (virtual environment optional)
5. Use Python to run Ben's code

### Future plans
1. I plan on bundling this into a Mac OS app, so that you only have a single file to maintain.
2. I would like to implement some kind of update functionality, so that you could easily upgrade to the newest version of Ben's code without me having to bundle and release a new version for each change.
3. Miscellaneous changes to Ben's code that would make some actions more verbose and user-friendly. He's a busy boy, so I'll have to discuss a good way to work with him on that in the future.
4. Create a video tutorial to walk ya through all of this, for the LAZY PEOPLE who **CAN'T READ** (jk, ilu bb's 😘)
