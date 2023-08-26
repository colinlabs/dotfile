#!/bin/bash

install_send_zmodem() {
    path="/usr/local/bin/iterm2-send-zmodem.sh"
    echo "Downloading iterm2-send-zmodem.sh"
    wget https://raw.githubusercontent.com/RobberPhex/iterm2-zmodem/master/iterm2-send-zmodem.sh -o $path
    chmod +x $path

    osascript -e 'tell application "iTerm2" to version' > /dev/null 2>&1 && NAME=iTerm2 || NAME=iTerm
    if [[ $NAME = "iTerm" ]]; then
        FILE=$(osascript -e 'tell application "iTerm" to activate' -e 'tell application "iTerm" to set thefile to choose file with prompt "Choose a file to send"' -e "do shell script (\"echo \"&(quoted form of POSIX path of thefile as Unicode text)&\"\")")
    else
        FILE=$(osascript -e 'tell application "iTerm2" to activate' -e 'tell application "iTerm2" to set thefile to choose file with prompt "Choose a file to send"' -e "do shell script (\"echo \"&(quoted form of POSIX path of thefile as Unicode text)&\"\")")
    fi
    if [[ $FILE = "" ]]; then
        echo Cancelled.
        # Send ZModem cancel
        echo -e \\x18\\x18\\x18\\x18\\x18
        sleep 1
        echo
        echo \# Cancelled transfer
    else
        sz "$FILE" --escape --binary --bufsize 4096
        sleep 1
        echo
        echo \# Received "$FILE"
    fi
}

install_recv_zmodem() {
    echo "Downloading iterm2-recv-zmodem.sh"
    wget -o  https://raw.githubusercontent.com/RobberPhex/iterm2-zmodem/master/iterm2-recv-zmodem.sh
    chmod +x /usr/local/bin/iterm2-recv-zmodem.sh

    osascript -e 'tell application "iTerm2" to version' > /dev/null 2>&1 && NAME=iTerm2 || NAME=iTerm
    if [[ $NAME = "iTerm" ]]; then
        FILE=$(osascript -e 'tell application "iTerm" to activate' -e 'tell application "iTerm" to set thefile to choose folder with prompt "Choose a folder to place received files in"' -e "do shell script (\"echo \"&(quoted form of POSIX path of thefile as Unicode text)&\"\")")
    else
        FILE=$(osascript -e 'tell application "iTerm2" to activate' -e 'tell application "iTerm2" to set thefile to choose folder with prompt "Choose a folder to place received files in"' -e "do shell script (\"echo \"&(quoted form of POSIX path of thefile as Unicode text)&\"\")")
    fi

    if [[ $FILE = "" ]]; then
        echo Cancelled.
        # Send ZModem cancel
        echo -e \\x18\\x18\\x18\\x18\\x18
        sleep 1
        echo
        echo \# Cancelled transfer
    else
        cd "$FILE"
        rz --rename --escape --binary --bufsize 4096 
        sleep 1
        echo
        echo
        echo \# Sent \-\> $FILE
    fi
}

install_send_zmodem