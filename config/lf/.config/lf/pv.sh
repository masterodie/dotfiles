#!/usr/bin/env bash
#
file=$1
w=$2
h=$3
x=$4
y=$5

filetype="$( file -Lb --mime-type "$file")"

if [[ "$filetype" =~ ^image ]]; then
    kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y}" "$file" < /dev/null > /dev/tty
    exit 1
fi

if [[ "$filetype" =~ ^video ]]; then
    # vidthumb is from here:
    # https://raw.githubusercontent.com/duganchen/kitty-pistol-previewer/main/vidthumb
    kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y}" "$(vidthumb "$file")" < /dev/null > /dev/tty
    exit 1
fi

case "$1" in
    *.tar*) tar tf "$1";;
    *.zip) unzip -l "$1";;
    *.rar) unrar l "$1";;
    *.7z) 7z l "$1";;
    *.pdf) pdftotext "$1" -;;
    *) highlight -O ansi "$1";;
esac
