#!/bin/bash

## This script takes two arguments:  
# 1. Regex expression to replace
# 2. Replacement expression  
# with the option of specifying private (--private or -p); defaults to public
# and it replaces all the expressions specified in the 1st argument with the expression specified in the 2nd argument for all zettels in the directory.  

## WARNING: Some sed operations may be difficult to reverse, especially if you're using capture groups. Beware. Always test your sed operations in a test environment and backup your zettelkasten directories. 

# Use cases:  
# 1. Fix internal (zettel) links - ./replace.sh '[\(.*\)](../\(.*\))' '[\1](../\2-private)'
# 2. ...

PUBLIC=$ZETDIR
PRIVATE=$ZETDIR_PRIVATE
OPTION=$PUBLIC

if [[ "$1" == "--private" || "$1" == "-p" ]]; then                                           
    OPTION=$PRIVATE                                                                          
    shift 1                                                                                  
fi

for file in "$OPTION"/*/README.md; do
    if [ -f "$file" ]; then
        sed -i "s|\\$1|\\$2|g" "$file"
    fi
done

## NOTE: I am using '|' as a delimiter, so you will need to include a '\' character before it if you plan to include it in your arguments, i.e. ./replace.sh 'foo\|bar' 'baz'
