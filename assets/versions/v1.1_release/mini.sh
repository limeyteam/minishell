#!/bin/bash
#! MiniShell Release 1.1
function jumpto() {
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}
helpMenu="help            Show this menu\nwelcome         Show the start screen\nexit            Quit the program\ndraw   [value]  Draw a value to the screen\nmsgbox [value]  Show a dialog box\ncls             Clear screen"
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

if [ "$1" = "-h" ]; then
    echo -e "\e[1;33m[Warning] \e[0;0mRunning in help mode. To run MiniShell normally, please do not use any arguments."
    echo -e "$helpMenu"
    exit 0
elif [ "$1" = "--help" ]; then
    echo -e "\e[1;33m[Warning] \e[0;0mRunning in help mode. To run MiniShell normally, please do not use any arguments."
    echo -e "$helpMenu"
    exit 0
fi
warning_dialog="\e[1;33m[Warning] \e[0;0mDialog not found. Please install it!"
warning_figlet="\e[1;33m[Warning] \e[0;0mFiglet not found. Please install it!"
warning_toilet="\e[1;33m[Warning] \e[0;0mToilet not found. Please install it!"
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo -e "\e[1;34m[Info] \e[0;0mChecking for packages.."
    command -v dialog >>/dev/null
    if [ "$?" == "1" ]; then
        echo -e "$warning_dialog"
    else
        successRate=$(($successRate + 1))
    fi
    command -v showfigfonts >>/dev/null
    if [ "$?" == "1" ]; then
        echo -e "$warning_figlet"
    else
        successRate=$(($successRate + 1))
    fi
    command -v toilet >>/dev/null
    if [ $? == "1" ]; then
        echo -e "$warning_toilet"
    else
        successRate=$(($successRate + 1))

    fi
    packagewarning="\e[0;31mPlease refer to this link for missing packages:\nhttps://github.com/coconutteamdev/minishell/tree/v1.1#troubleshooting"
    if [ "$successRate" == "3" ]; then
        echo -e "\e[1;34m[Info] \e[0;0mPackage checking success."
        echo -e "\e[1;34m[Info] \e[0;0mIf there are any problems, please see Troubleshooting:\n\e[1;34m[Info] \e[4mhttps://github.com/coconutteamdev/minishell/tree/v1.1#troubleshooting\e[24m"
    elif [ "$successRate" == "1" ]; then
        echo -e "$packagewarning"
        echo -e "\e[1;33m[Warning] \e[0;0mMissing 2 packages. Please check above."
    elif [ "$successRate" == "2" ]; then
        echo -e "$packagewarning"
        echo -e "\e[1;33m[Warning] \e[0;0mMissing 1 package. Please check above."
    elif [ "$successRate" == "" ]; then
        echo -e "$packagewarning"
        echo -e "\e[1;31m[Error] \e[0;0mMissing all required packages. Please check above."
    fi
    command -v toilet >>/dev/null
    if [ $? == "0" ]; then
        toilet "MiniShell" -f mini --metal
    elif [ $? == "1" ]; then
        echo "Cannot display MiniShell logo. Rendering in fallback mode."
    fi
    echo -e "\e[1;34mMiniShell \e[1;35mRelease 1.1 \e[0;0mby CoconutDev. Type \e[1;36mhelp \e[0;0mfor commands."
    jumpto $start
else
    echo -e "\e[1;31m[Error] \e[0;0mPlease do not run MiniShell as root or sudo."
    exit
fi

start:
# Show the MiniShell prompt
echo -n -e "\e[1;34mmini>\e[0;0m "
IFS=$'\t'
array=("help\tdraw\texit\tmsgbox\tcls\twelcome\treset\tgh\tsh")
unset IFS
read value
if [[ "\t${array[@]}\t" =~ "\t${value}\t" ]]; then
    if [ "$value" == "help" ]; then
        echo -e "$helpMenu"
        jumpto $start
    elif [ "$value" == "gh" ]; then
        printf '\nOpening.. '
        spinner &

        xdg-open https://github.com/coconutteamdev/minishell

        kill "$!" # kill the spinner
        jumpto $start
    elif [ "$value" == "sh" ]; then
        jumpto minibash
    elif [ "$value" == "exit" ]; then
        echo "Exiting"
        exit
    elif [ "$value" == "cls" ]; then
        clear
        jumpto $start
    elif [ "$value" == "draw" ]; then
        echo -e -n "$value: invalid syntax\nusage: draw [value]\n"
        jumpto $start
    elif [ "$value" == "msgbox" ]; then
        echo -e -n "$value: invalid syntax\nusage: msgbox [value]\n"
        jumpto $start
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
    jumpto $start
elif [[ "$value" == *"msgbox "* ]]; then
    echo $value >>file.tmp
    cut -c 8- file.tmp >>file2.tmp
    rm file.tmp
    file=$(cat file2.tmp)
    command -v dialog >>/dev/null
    if [ "$?" == "1" ]; then
        echo -e "$warning_dialog"
        echo -e "$packagewarning"
    elif [ "$?" == "0" ]; then
        dialog --title "MiniMsg" --msgbox "$file" 0 0
    fi
    rm file2.tmp
    jumpto $start
else
    # Added command guessing (Might add highlighting soon if it's possible)
    # Example: User types "exi" and it will trigger the ex below and say:
    # "exi: invalid command -- did you mean exit?"
    if [[ "$value" == *"set "* ]]; then
        echo -e "\e[1;31m[Error] \e[0;0mThe set command is unfinished. Try another."
        jumpto $start
    elif [[ "$value" == *"ex"* ]]; then
        echo "$value: invalid command -- did you mean exit?"
        jumpto $start
    elif [[ "$value" == *"wel"* ]]; then
        echo "$value: invalid command -- did you mean welcome?"
        jumpto $start
    elif [[ "$value" == *"c"* ]]; then
        echo "$value: invalid command -- did you mean cls?"
        jumpto $start
    elif [[ "$value" == *"d"* ]]; then
        echo "$value: invalid command -- did you mean draw?"
        jumpto $start
    elif [[ "$value" == *"m"* ]]; then
        echo "$value: invalid command -- did you mean msgbox?"
        jumpto $start
    elif [ "$value" == "" ]; then
        jumpto $start # fixed in v1.1
    elif [[ "$value" == *"echo"* ]]; then
        echo -e -n "$value: invalid command -- did you mean draw?\n"
        jumpto $start
    else
        echo -e -n "$value: invalid command -- type help for commands\n"
        jumpto $start
    fi
fi

welcome:
toilet "MiniShell" -f mini --metal
echo -e "\e[1;34mMiniShell \e[1;35mRelease 1.1 \e[0;0mby CoconutDev. Type help for commands."
jumpto $start

minibash:
echo -e "\e[1;32mComing in MiniShell release 1.2"
jumpto $start


#* Ignore this stuff please :|

# toilet "MiniBash" -f mini --metal

# echo -e "\e[1;34mMiniShell \e[1;35mv1.1 \e[0;0mby CoconutDev. Type \e[1;36mhelp \e[0;0mfor commands."
# IFS=$'\t'
# array=("help\tdraw\texit\tmsgbox\tcls\twelcome\treset\tgh")
# unset IFS
# # Show the MiniShell prompt
# echo -n -e "\e[1;34mminibash>\e[0;0m "
# read BashValue
# if [[ "\t${BashArray[@]}\t" =~ "\t${BashValue}\t" ]]; then
#     if [ "$BashValue" == "help" ]; then
#         echo -e "$helpBash"
#         jumpto minibash
#     elif [ "$BashValue" == "exit" ]; then
#         echo "Exiting"
#         exit
#     elif [ "$BashValue" == "cls" ]; then
#         clear
#         jumpto minibash
#     fi
# elif [[ "$BashValue" == *"draw "* ]]; then
#     echo $BashValue >>file.tmp
#     cut -c 6- file.tmp
#     rm file.tmp
#     jumpto minibash
# elif [[ "$BashValue" == *"msgbox "* ]]; then
#     echo $BashValue >>file.tmp
#     cut -c 8- file.tmp >>file2.tmp
#     rm file.tmp
#     file=$(cat file2.tmp)
#     dialog --title "MiniMsg" --msgbox "$file" 0 0
#     rm file2.tmp
#     jumpto minibash
# else
#     if [[ "$BashValue" == *"set "* ]]; then
#         echo -e "\e[1;31m[Error] \e[0;0mThe set command is unfinished. Try another."
#         jumpto minibash
#     elif [ "$BashValue" == "" ]; then
#         jumpto minibash
#     else
#         echo $BashValue: invalid command
#         jumpto minibash
#     fi
# fi
