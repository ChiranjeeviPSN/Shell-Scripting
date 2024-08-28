#!/bin/bash
# echo $0  # outputs script filename
# echo $0 | cut -d "." -f1 #Outputs the first field from the input, using the delimiter(.) specified.

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

CHECK_ROOT(){
    if [ "$USERID" != 0 ]
    then
        echo -e "$R Run as root..$N" | tee -a $LOG_FILE
# 'tee' command outputting text to both the terminal (standard output) and one or more files.
# -a option with tee tells it to append the data to the file specified, rather than overwriting the file
        exit 1
    fi
}

VALIDATE(){
    if [ $1 != 0 ]
    then
        echo -e "$2 is ..$R FAILED $N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$2 is .. $G Success $N" | tee -a $LOG_FILE
    fi
}

USAGE(){
    echo -e "$R USAGE:: $N sudo sh redirections.sh package1 package2 .."
    exit 1
}

echo "Script started executing at: $(date)" | tee -a $LOG_FILE

CHECK_ROOT

if [ $# == 0 ]
then
    USAGE
fi

for package in $@
do
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ]
    then
        echo "$package is not installed, going to install it.." | tee -a $LOG_FILE
        dnf install $package -y &>>$LOG_FILE
# &>>$LOG_FILE --> Redirects both the output and errors from the dnf command to the file specified by $LOG_FILE
        VALIDATE $? "Installing $package"
    else
        echo -e "$package is already $Y installed..nothing to do $N" | tee -a $LOG_FILE
    fi
done