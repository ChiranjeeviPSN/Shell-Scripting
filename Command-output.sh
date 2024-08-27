#!/bin/bash

DATE=$(date +%F)

echo "Today's date: $DATE"

# special variables

echo "All variables passed to script: $@"
echo "Number of variables passed: $#"
echo "script name: $0"
echo "current working directory: $PWD"
echo "Home directory of current user: $HOME"
echo "PID of the script executing now: $$"

sleep 100 &
echo "PID of the last background command: $!"