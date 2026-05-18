#!/bin/bash
parser="$HOME/.config/theme-setter/scripts/parser.sh"
wallpapers="$HOME/Dropbox/Pictures/Wallpapers"
local_path="$HOME/.local/share"

theme=$($parser --theme)
mode=$($parser --mode)
tone=$($parser --tone)
current_wallpaper=$($parser --wallpaper)

wallpaper_ls="ls $wallpapers/$theme"

if [ "$current_wallpaper" != "" ]; then
    wallpaper_ls="$wallpaper_ls -I $current_wallpaper"
fi

new_wallpaper=$($wallpaper_ls | sort -R | tail -1)
$parser --set-wallpaper "$new_wallpaper"

# if [ $mode == "dark" ]; then
#     if [ $tone == "hard" ]; then
#         fill="50%" 
#     else
#         fill="25%"
#     fi
# else
#     fill="15%"
# fi
#
# magick "$wallpapers/$theme/$new_wallpaper" \
#     -fill "#$($parser --palette backgroundAlt)" \
#     -colorize $fill \
#     -fill "#$($parser --palette orange)" \
#     -colorize 10% \
#     "$local_path/wallpaper.jpg"
cp $wallpapers/$theme/$new_wallpaper $local_path/wallpaper.jpg

awww img "$local_path/wallpaper.jpg" \
    --transition-type wipe \
    --transition-angle 30 \
    --transition-step 90

cp "$local_path/wallpaper.jpg" \
    "/usr/share/sddm/themes/dynamic/background.jpg"
