#!/bin/bash

function article_name() {
    basename --suffix ".md" "$1"
}

function escape_space() {
    echo "$*" | sed 's/ /%20/g'
}

ls -1t ./content | while read -r i; do
        ia=$(article_name "$i")
        ie=$(escape_space "$i")

        if [ -f "content/$i" ]; then
            echo "- [$ia](content/$ie)"
        elif [ -d "content/$i" ]; then
            echo "- $ia"
            ls -1 "content/${i}" | grep '.md$' | while read -r j; do
                ja=$(article_name "$j")
                je=$(escape_space "$j")
                
                echo -e "\t - [$ja](content/$ie/$je)"
            done
       fi
    done

# ls -1t content \
    # | grep "\.md$" \
    # | sed 's/\(.*\)\.\(.*\)/- [\1](content\/\1.\2)/' \
    # | sed 's/\((.*\) \(.*)\)/\1%20\2/g'
