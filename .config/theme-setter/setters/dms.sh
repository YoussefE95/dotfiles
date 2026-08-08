#!/bin/bash
palette=("${@}")

dest_dir="$HOME/.config/DankMaterialShell/"
dest_file="theme.json"

output="$(cat << THEME
{
    "name": "Dynamic Theme",
    "primary": "#${palette[10]}",
    "primaryText": "#${palette[0]}",
    "primaryContainer": "#${palette[8]}",
    "secondary": "#${palette[5]}",
    "surface": "#${palette[0]}",
    "surfaceText": "#${palette[2]}",
    "surfaceVariant": "#${palette[3]}",
    "surfaceVariantText": "#${palette[2]}",
    "surfaceTint": "#${palette[8]}",
    "background": "#${palette[0]}",
    "backgroundText": "#${palette[2]}",
    "outline": "#${palette[3]}",
    "surfaceContainer": "#${palette[0]}",
    "surfaceContainerHigh": "#${palette[1]}",
    "error": "#${palette[4]}",
    "warning": "#${palette[6]}",
    "info": "#${palette[5]}"
}
THEME
)"

printf '%s' "$output" > "${dest_dir}${dest_file}"

dms ipc call wallpaper set \
    $(find "$HOME/Dropbox/Pictures/Wallpapers/${palette[11]}" \
    -maxdepth 1 -type f | shuf -n 1)
