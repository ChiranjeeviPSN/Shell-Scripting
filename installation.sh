#!/bin/bash

USERID=$(id -u)
echo "User ID is: $USERID"

if [ $USERID -ne 0 ]
then 
    echo "Run the script as root"
    ls
    exit 1
    ls -l
fi

dnf list installed git

if [ $? -ne 0 ]
then
    echo "Git not installed. Installing git.."
    dnf install git -y
    if [ $? -ne 0 ]
    then
        echo "Git installation Unsuccessful.."
        exit 1
    else
        echo "Git installation successful.."
    fi
else
    echo "Git already installed"
fi