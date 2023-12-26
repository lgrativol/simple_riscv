#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <name>"
    exit 1
fi

# Get the filename from the command line argument
original_file="/home/l17grati/playground/hardware/cpu/scrap/template.vhd"

new_filename="$1"
new_filename+=".vhd"

# Check if the file exists
if [ ! -e "$original_file" ]; then
    echo "Error: File '$original_file' not found."
    exit 1
fi

# Copy the file to the current directory with the new filename
cp "$original_file" "$new_filename"

exit 0
