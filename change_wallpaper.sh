
#!/bin/bash


WALLPAPERS_LOCATION=~/Pictures/wallpapers
PATH_FROM_WP_LOC_TO_USING="using/wp"
TEMP=false

usage() {
    echo "Usage: $0 [-t|--temp] <file_path>"
    echo "Options:"
    echo "  -t, --temp    Make the change last only current session"
    exit 1
}


while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        -t|--temp)
        TEMP=true
        shift
        ;;
        *)
        FILE_PATH="$1"
        shift
        ;;
    esac
done



if [ -z $FILE_PATH ]; then
    # print available wallpapers
    ls -p  "$WALLPAPERS_LOCATION" | grep -v /$   
    exit 0;
fi

if [ ! -f "$FILE_PATH" ]; then

    if [ -f "$WALLPAPERS_LOCATION"/"$FILE_PATH" ]; then
	# Set wallpaper
	CURR_WP="$WALLPAPERS_LOCATION"/"$FILE_PATH" 
	feh --bg-scale "$CURR_WP" || (echo "Error: Could not set as wallpaper." && exit 1);

	if [ "$TEMP" = false ]; then
	    cp "$CURR_WP" "$WALLPAPERS_LOCATION"/"$PATH_FROM_WP_LOC_TO_USING";
	fi
	exit 0;

    else
	echo "Error: File not found at $FILE_PATH."
	exit 1
    fi
fi

# get file name
FILE_NAME= echo "$FILE_PATH" | rev | cut -d'.' -f 1 | rev
# Set wallpaper
feh --bg-scale "$FILE_PATH" || (echo "Error: Could not set as wallpaper." && exit 1);

if [ -f  "$WALLPAPERS_LOCATION"/"$FILE_NAME" ]; then
	echo "File already in wallpaper directory.";
else
	cp "$FILE_PATH" "$WALLPAPERS_LOCATION"/"$FILE_NAME";
fi

# Change it so its permanent
if [ "$TEMP" = false ]; then
    cp "$FILE_PATH" "$WALLPAPERS_LOCATION"/"$PATH_FROM_WP_LOC_TO_USING";
fi


exit 0;

