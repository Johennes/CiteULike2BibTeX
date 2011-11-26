#!/bin/bash

##############################################################################
## citeulike2bibtex.sh
##
## Copyright 2011 Johannes Marbach. All rights reserved.
## See the LICENSE file for details.

##############################################################################
## Standard CiteULike settings

# Default CiteULike username (can be overridden on CLI)
USER=hennes

# Prefix BibTeX keys with username (0 = False / 1 = True)
PREFIX=0

# Bibtex key type
#   0 = personal, otherwise numeric
#   4 = personal, otherwise AuthorYearTitle
#   1 = numeric
#   2 = export only personal keys
#   3 = export both keys
KEY=4

# Include Amazon URL (0 = False / 1 = True)
AMAZON=0

# Escape URLs (0 = False / 1 = True)
ESCAPE=1

# Smart wrapping
#   0 = don't wrap
#   1 = smart wrap field
#   2 = smart wrap words
WRAP=1

##############################################################################
## Additional settings

# Default output filename (can be overridden on CLI)
OUT=main.bib

# Fields to be erased from the library
BLACKLIST=("abstract" "citeulike" "keywords" "month" "posted-at" "priority")

# Remove trailing + on pages fields (0 = False / 1 = True)
STRIPPLUS=1

# Unescape math commands (0 = False / 1 = True)
UNDOMATH=1

##############################################################################
## Script action

function usage
{
    echo "USAGE: citeulike2bibtex.sh [OPTION]"
    echo
    echo "Options:"
    echo "  -u, --user     CiteULike username"
    echo "  -o, --output   Output filename"
    echo "  -h, --help     Display this message and exit"
    echo
}

function error
{
    echo "ERROR: "$1
    exit 1
}

# Parse CLI options
while [ "$1" != "" ]; do
    case $1 in
        -u | --user )
            shift
            USER=$1
            ;;
        -o | --output )
            shift
            OUT=$1
            ;;
        -h | --help )
            usage
            exit
            ;;
        * )
            usage
            exit 1
            ;;
    esac
    shift
done

# Check arguments
if [ -z "$USER" ]; then
    error "No username supplied"
fi
if [ -z "$OUT" ]; then
    error "No output filename supplied"
fi

# Download bibtex file
wget "http://www.citeulike.org/bibtex/user/$USER?do_username_prefix=$PREFIX"\
"&key_type=$KEY&incl_amazon=$AMAZON&clean_urls=$ESCAPE&smart_wrap=$WRAP" -O $OUT

# Strip blacklisted fields
for field in ${BLACKLIST[@]}; do
    TMP=$(mktemp)
    awk "/${field}.* *= *{/{a=1} (a && /} *,$/){a=0;next;}!a" $OUT > $TMP && mv $TMP $OUT
done

# Strip potential comma before closing }
sed -i "/,$/{
    N
    s/,\n}/\n}/
}" $OUT

# Remove trailing + on pages fields
if [ $STRIPPLUS = 1 ]; then
    sed -i '/\s*pages.*/s/+}/}/' $OUT
fi

# Unescape math commands
if [ $STRIPPLUS = 1 ]; then
    sed -i 's/\\\$/\$/g' $OUT
    sed -i 's/\\_/_/g' $OUT
fi
