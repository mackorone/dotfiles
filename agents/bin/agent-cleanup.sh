#!/bin/bash
# Strip trailing whitespace and ensure exactly one trailing newline.
FILE="$1"

if [ -f "$FILE" ]; then
    # 1. Strip trailing whitespace from every line
    sed -i 's/[[:space:]]*$//' "$FILE"

    # 2. Remove all trailing empty lines.
    # Most versions of sed will ensure the final line ends with a single \n.
    sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' "$FILE"
else
    echo "Error: File not found: $FILE"
    exit 1
fi
