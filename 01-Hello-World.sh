#!/bin/bash

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$3 is...FAILED"
        exit 1
    else
        echo "$3 is...SUCCESS"
    fi
}

echo "Hello World"
VALIDATE $? "Command" "failed command"