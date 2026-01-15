#!/bin/bash

# In linux system, temporary and old files can occupy disk space unnecessarily. user ofter manualy find and delete files older than certain number of days.This script solve that issue user can give the directory path and that are older than specified number of days will be deleted.

# I also added getopts concept here to pass arguments through command line getopts reads options like -d and -n and assigns their values to variables. 
# using CASE statement to take the user input of directory and number of days to delete the file. 
# If just want to check the file remove -r option to avoid accidental deleting.
# If we enter other option it will throw and invalid error

while getopts "d:n:rh" opt; do
	case $opt in
		d) DIR="$OPTARG" ;;
		n) DAYS="$OPTARG" ;;
		r) REMOVE="true" ;;
		*) echo "Invalid option"
			exit 1
			;;
	esac
done

# If the directory and number of days not entered then it will throw an error directory and days are required
if [ -z "$DIR" ] || [ -z "$DAYS" ];
then
	echo "Error: Directory and days are required"
	exit 1
fi

# If the entered directory is not valid it will throw an error directory does not exist
if [ ! -d "$DIR" ];
then
	echo "Error: Directory does not exist"
	exit 1
fi

# Created a variable FILES which store the details of file older than the given number of days
FILES=$(find "$DIR" -type f -mtime +"$DAYS")

# If there us no file older than days user entered then it will throw an error
if [ -z "$FILES" ];
then
	echo "There is no file older than $DAYS days."
	exit 0
fi

# To print the files older than specic date and from the specific directory
echo "Files older than $DAYS days in $DIR:"

# If we add option -r at the end of the command it will delete the file match the criteria to just view the file before deleting just remove -r from the command
if [ "$REMOVE" = true ]; 
then
	find "$DIR" -type f -mtime +"$DAYS" -print -delete
	echo "Older file deleted."
else
	find "$DIR" -type f -mtime +"$DAYS" -print
fi
