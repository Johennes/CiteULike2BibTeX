#!/bin/bash

## Settings

# CiteULike username
USER=hennes

# Fields to be erased from the library
BLACKLIST=("abstract" "citeulike" "keywords" "month" "posted-at" "priority")

# Output file name
OUT=main.bib

# Username prefix (0 = False / 1 = True)
PREFIX=0

# Bibtex key type
#   0 = personal otherwise numeric
#   4 = personal otherwise AuthorYearTitle
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

# Remove trailing + on pages fields (0 = False / 1 = True)
STRIPPLUS=1

# Unescape math commands (0 = False / 1 = True)
UNDOMATH=1


## Action

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
