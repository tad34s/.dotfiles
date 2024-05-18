#!/bin/bash

WALLPAPERS_LOCATION=~/Pictures/wallpapers
PATH_FROM_WP_LOC_TO_USING="using/wp"
TEMP=false

usage() {
    local CM_NAME=$(basename "$0")
    echo "Usage: $CM_NAME [-t|--temp] [IMAGE]"
    echo "Options:"
    echo "  -t, --temp    Make the change last only current session"
    echo "  -h, --help    Display this help message"
    echo "----------------------------------------------------------------------------"
    echo "Set the image as wallpaper"
    echo "Provide a path to image or a name of the image if it is in the wallpaper directory (specified in the script)."
    echo "If nothing is provided will open ranger for you to pick the wallpaper"
    exit 1
}

set_wallpaper() {
    local filepath="$1"
    feh --bg-scale "$filepath" || { echo "Error: Could not set as wallpaper."; exit 1; }

}

copy_to_wallpapers() {
    local src="$1"
    local dest="$2"
    cp "$src" "$dest" && return 0
    return 1
}

select_wallpaper() {
    ranger --choosefiles=temp "$WALLPAPERS_LOCATION"
    local filepath=$(cat temp)
    rm temp
    echo "$filepath"
}

get_path(){
    local full_path="$WALLPAPERS_LOCATION/$1"
    if [ -f "$full_path" ]; then
        echo "$full_path"
    fi
}

main() {
    local FILE_PATH="$1"

    # IF PATH NOT PROVIDED
    if [ -z "$FILE_PATH" ]; then
        #FILE_PATH=$(select_wallpaper)
        ranger --choosefiles=temp "$WALLPAPERS_LOCATION"
        FILE_PATH=$(cat temp)
        rm temp
    fi



    if [ ! -f "$FILE_PATH" ]; then # PATH IS NOT ABSOLUTE
        FILE_PATH=$(get_path "$FILE_PATH")
        if [ -f "$FILE_PATH" ]; then
            set_wallpaper "$FILE_PATH"
        else
            echo "Error: File not found at $FILE_PATH."
            exit 1
        fi
    fi

    local FILE_NAME=$(basename "$FILE_PATH")
    set_wallpaper "$FILE_PATH"

    if [ ! -f "$WALLPAPERS_LOCATION/$FILE_NAME" ]; then
        copy_to_wallpapers "$FILE_PATH" "$WALLPAPERS_LOCATION/$FILE_NAME"
        echo "Adding new WP to archive"
    fi

    if [ "$TEMP" = false ]; then
        copy_to_wallpapers "$FILE_PATH" "$WALLPAPERS_LOCATION/$PATH_FROM_WP_LOC_TO_USING"
        echo "Wallpaper has been set!"
    else
        echo "Wallpaper has been set for this session!"
    fi
}

while [[ $# -gt 0 ]]; do
    case $1 in
        -t|--temp)
            TEMP=true
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            FILE_PATH="$1"
            shift
            ;;
    esac
done

main "$FILE_PATH"

exit 0
