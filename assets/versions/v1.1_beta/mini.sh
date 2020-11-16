#!/bin/bash
#Setup the functions
function jumpto() {
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}

spinner() {
    local i sp n
    sp='/-\|'
    n=${#sp}
    printf ' '
    while sleep 0.1; do
        printf "%s\b" "${sp:i++%n:1}"
    done
}

start=${1:-"start"}

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo -e "\e[1;34m[Info] \e[0;0mChecking for packages.."
    command -v dialog >>/dev/null
    if [ "$?" == "1" ]; then
        echo -e "\e[1;37m[Warning] \e[0;0mDialog not found. Please install it!"
    else
        successRate=$(($successRate + 1))
    fi
    command -v figlet >>/dev/null
    if [ "$?" == "1" ]; then
        echo -e "\e[1;37m[Warning] \e[0;0mFiglet not found. Please install it!"
    else
        successRate=$(($successRate + 1))
    fi
    command -v toilet >>/dev/null
    if [ $? == "1" ]; then # exeon takes a bath 5:10 PM 11/13/20 also i had idea to make the echo comamnd the draw command like draw the logo at startup i tried that idk
        echo -e "\e[1;37m[Warning] \e[0;0mToilet not found. Please install it!"
    else
        successRate=$(($successRate + 1))
        toilet "MiniShell" -f mini --metal
    fi
    packagewarning="\e[0;31mPlease refer to this link for missing packages:\nhttps://github.com/coconutteamdev/minishell/tree/v1.0#troubleshooting"
    if [ "$successRate" == "3" ]; then
        echo -e "\e[1;34m[Info] \e[0;0mPackage checking success."
    elif [ "$successRate" == "1" ]; then
        echo -e "$packagewarning"
        echo -e "\e[1;37m[Warning] \e[0;0mMissing 2 packages. Please check above."
    elif [ "$successRate" == "2" ]; then
        echo -e "$packagewarning"
        echo -e "\e[1;37m[Warning] \e[0;0mMissing 1 package. Please check above."
    elif [ "$successRate" == "" ]; then
        echo -e "$packagewarning"
        echo -e "\e[1;31m[Error] \e[0;0mMissing all required packages. Please check above."
    fi
    echo -e "\e[1;36mMiniShell v1.1 \e[0;0mby CoconutDev. Type \e[1;36mhelp \e[0;0mfor commands."
    jumpto $start
else
    echo -e "\e[1;31m[Error] \e[0;0mPlease do not run MiniShell as root or sudo."
    exit
fi

start:
# Show the MiniShell prompt
echo -n -e "\e[1;34mminishell>\e[0;0m "
IFS=$'\t'
array=("help\tdraw\texit\tmsgbox\tcls\twelcome\treset\tgh")
unset IFS
read value
if [[ "\t${array[@]}\t" =~ "\t${value}\t" ]]; then
    if [ "$value" == "help" ]; then
        echo -e "help            Show this menu\nwelcome         Show the start screen\nexit            Quit the program\necho   [value]  Print a value\nmsgbox [value]  Show a dialog box\ncls             Clear screen"
        jumpto start
    elif [ "$value" == "gh" ]; then
        printf '\nOpening.. '
        spinner &

        xdg-open https://github.com/coconutteamdev/minishell

        kill "$!" # kill the spinner
        printf '\n'
        jumpto start
    elif [ "$value" == "exit" ]; then
        echo "Exiting"
        exit
    elif [ "$value" == "cls" ]; then
        clear
        jumpto start
    elif [ "$value" == "welcome" ]; then
        clear
        jumpto welcome
    elif [ "$value" == "reset" ]; then
        clear
        $(basename $0) && clear && exit
    elif [ "$value" == "github" ]; then
        echo "Opening the GitHub repo..."
        xdg-open https://www.github.com/coconutteamdev/minishell

    fi
elif [[ "$value" == *"draw "* ]]; then
    echo $value >>file.tmp
    cut -c 6- file.tmp
    rm file.tmp
    jumpto start
elif [[ "$value" == *"msgbox "* ]]; then
    echo $value >>file.tmp
    cut -c 8- file.tmp >>file2.tmp
    rm file.tmp
    file=$(cat file2.tmp)
    dialog --title "MiniMsg" --msgbox "$file" 0 0
    rm file2.tmp
    jumpto start
else
    if [[ "$value" == *"set "* ]]; then
        echo -e "\e[1;31m[Error] \e[0;0mThe set command is unfinished. Try another."
        jumpto start
    elif [ "$value" == *"exit"* ]; then
        echo "$value: invalid command --did you mean exit?"
        jumpto start
    elif [ "$value" == *"welcome"* ]; then
        echo "$value: invalid command --did you mean welcome?"
        jumpto start
    elif [ "$value" == *"cls"* ]; then
        echo "$value: invalid command --did you mean cls?"
        jumpto start
    elif [ "$value" == "" ]; then
        jumpto start
    else
        echo $value: invalid command
        jumpto start
    fi
fi

welcome:
toilet "MiniShell" -f mini --metal
echo -e "\e[1;34mMiniShell \e[1;35mv1.1 \e[0;0mby CoconutDev. Type \e[1;36mhelp \e[0;0mfor commands."
jumpto start
