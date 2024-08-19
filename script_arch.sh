#!/bin/bash

# Check if the number of argument is correct
if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <filename> <destination directory>"
	exit 1
fi

# get file we are trying to move  and the destination directory from the argument
FILENAME=$1
DEST_DIR=$2

# check if file exists in the destination directory
if [ -f "$DEST_DIR/$FILENAME" ]; then
	echo "The file $FILENAME already exists in the destination directory $DEST_DIR."
	exit 1
fi

# list of directories that contain archived files
FOLDERS="cpc-utility OLD-UTILITY-01 UTILITY-FILES cpcutility-Archive cpcutility-Archive1 utility-01"

# all files in the specified directories
FOUND_FILES=$(find $FOLDERS -type f -name "$FILENAME")

# check if found files is empty
if [ -z "$FOUND_FILES" ]; then
	echo "No files named $FILENAME found in the specified directories."
	exit 0
fi

# a variable that changes if file has been moved
MOVED=false

# iterate over the found files, move it on the first occurence and change MOVED to true, deletes for all other instances
for FILE in $FOUND_FILES; do
	if [ "$MOVED" = false ]; then
		mv -v "$FILE" "$DEST_DIR/"
		MOVED=true
	else
		rm -v "$FILE"
	fi
done

# checks if it is successful or not
if [ -f "$DEST_DIR/$FILENAME" ]; then
	echo "File $FILENAME successfully moved to $DEST_DIR and other occurences deleted."
else
	echo "Error: File $FILENAME was not moved to $DEST_DIR"
fi

