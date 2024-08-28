#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"

CHECK_ROOTt(){
    if [ $USERID -ne 0 ]
    then
        echo "run script with root privileges"
        exit 1
}

VALIDATEe(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2 is...$R FAILED $N"
        exit 1
    else
        echo -e "$2 is...$G SUCCESS $N"
    fi
}

CHECK_ROOTt

for package in $@
do
    dnf list installed $package
    if [ $? -ne 0 ]
    then
        echo "$package is not installed, going to install it"
        dnf install $package -y
        VALIDATEe $? "Installing $package"
    else
        echo "$package is already installed..nothing to do"
    fi
done