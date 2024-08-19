#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <filename> <destination directory>"
	exit 1
fi

FILENAME=$1
DEST_DIR=$2


if [ -f "$DEST_DIR/$FILENAME" ]; then
	echo "The file $FILENAME already exists in the destination directory $DEST_DIR."
	exit 1
fi


FOLDERS="A B C D E F"


FOUND_FILES=$(find $FOLDERS -type f -name "$FILENAME")

if [ -z "$FOUND_FILES" ]; then
	echo "No files named $FILENAME found in the specified directories."
	exit 0
fi

MOVED=false
for FILE in $FOUND_FILES; do
	if [ "$MOVED" = false ]; then
		mv -v "$FILE" "$DEST_DIR/"
		MOVED=true
	else
		rm -v "$FILE"
	fi
done

if [ -f "$DEST_DIR/$FILENAME" ]; then
	echo "File $FILENAME successfully moved to $DEST_DIR and other occurences deleted."
else
	echo "Error: File $FILENAME was not moved to $DEST_DIR"
fi

