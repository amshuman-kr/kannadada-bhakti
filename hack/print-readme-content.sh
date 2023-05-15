#!/bin/bash

function article_name() {
    basename --suffix ".md" "$1"
}

function escape_space() {
    echo "$*" | sed 's/ /%20/g'
}

function print_authors() {
    local article="$1"

    # Read bullet points in Authors section in the markdown file  in $article.
    # Then, print the authors in the format of "Author1, Author2 and Author3".
    # Hint: Use `awk` to extract the lines between the lines starting with
    # "## Authors" and "##" (the end of the Authors section), remove the bullet points, empty lines.

    awk '/^## ಬರೆಹಗಾರರು/,/^## [^ಬ]/ {print}' "$article" \
        | grep -v '##' \
        | grep -v '^\s*$' \
        | sed 's/^\s*- //' \
        | sed 's/^\s*//' \
        | sed 's/\s*$//' \
        | sed 's/\([^,]\)$/\1,/' \
        | sed 's/,$//' \
        | sed 's/\(.*\), /\1, and /'
}

ls -1t ./content | while read -r i; do
        ia=$(article_name "$i")
        ie=$(escape_space "$i")
        authors=$(print_authors "content/$i")

        if [ -f "content/$i" ]; then
            echo "- [$ia](content/$ie) ($authors)"
        elif [ -d "content/$i" ]; then
            echo "- $ia"
            ls -1 "content/${i}" | grep '.md$' | while read -r j; do
                ja=$(article_name "$j")
                je=$(escape_space "$j")
                authors=$(print_authors "content/$i/$j")
                
                echo -e "\t - [$ja](content/$ie/$je) ($authors)"
            done
       fi
    done

# ls -1t content \
    # | grep "\.md$" \
    # | sed 's/\(.*\)\.\(.*\)/- [\1](content\/\1.\2)/' \
    # | sed 's/\((.*\) \(.*)\)/\1%20\2/g'
