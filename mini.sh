#!/bin/bash
#Setup the functions
toilet "MiniShell" -f mini --metal
echo -e "\e[1;34mMiniShell \e[1;35m1.0 \e[0;0mby Kat21. Type \e[1;36m'help' \e[0;0mfor commands."
function jumpto() {
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}

start=${1:-"start"}
echo "Checking for packages.."
command -v toilet
if [ "$?" == "1" ]; then
    echo "Toilet not found. Please install it!"
fi

jumpto $start

start:
printf "mini> "
# Ask the user for their name
# printf "$ "
IFS=$'\t'
array=("help\techo\texit\tmsgbox\tcls\twelcome")
unset IFS
read value
if [[ "\t${array[@]}\t" =~ "\t${value}\t" ]]; then
    if [ "$value" == "help" ]; then
        echo -e "help        Show this menu\nwelcome     Show the start screen\nexit        Quit the program\necho        Print a value\nmsgbox      Show a dialog box\ncls         Clear screen"
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
    fi
elif [[ "$value" == *"echo "* ]]; then
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
    echo $value: invalid command
    jumpto start
fi

welcome:
toilet "MiniShell" -f mini --metal
echo -e "\e[1;34mMiniShell \e[1;35m1.0 \e[0;0mby Kat21. Type \e[1;36m'help' \e[0;0mfor commands."
jumpto start