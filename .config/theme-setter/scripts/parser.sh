#!/bin/bash
current="$HOME/.config/theme-setter/info/current.json"
themes="$HOME/.config/theme-setter/info/themes.json"

set() {
    tmp=$(mktemp)
    jq ".$1 = \"$2\"" $current > $tmp && mv $tmp $current
}

query() {
    jq $1 $2 | sed 's/\"//g'
}

get() {
    query ".$1" $current
}

get_icons() {
    query ".$(get "theme").icons" $themes
}

get_cursors() {
    query ".$(get "theme").cursors.$(get "mode")" $themes
}

get_palette() {
    query ".$(get "theme").palette.$(get "mode").$(get "tone").$1" $themes
}

get_full_palette() {
    query ".$(get "theme").palette.$(get "mode").$(get "tone")|.[]" $themes
}

get_supported() {
for theme in $(jq -r "keys[]" $themes)
do
    for mode in $(jq -r ".${theme}.palette" $themes | jq -r "keys[]")
    do
        for tone in $(jq -r ".${theme}.palette.${mode}" $themes | jq -r "keys[]")
        do
            echo "$theme $mode $tone"
        done
    done
done
echo "Current: $(get 'theme') $(get 'mode') $(get 'tone')"
}

if [ "$1" == "--set" ]; then
    set "theme" $2
    set "mode" $3
    set "tone" $4
elif [ "$1" == "--set-wallpaper" ]; then
    set "wallpaper" $2
elif [ "$1" == "--full" ]; then
    echo "$(get "theme") $(get "mode") $(get "tone")"
elif [ "$1" == "--theme" ]; then
    get "theme"
elif [ "$1" == "--mode" ]; then
    get "mode" 
elif [ "$1" == "--tone" ]; then
    get "tone"
elif [ "$1" == "--wallpaper" ]; then
    get "wallpaper"
elif [ "$1" == "--icons" ]; then
    get_icons
elif [ "$1" == "--cursors" ]; then
    get_cursors
elif [ "$1" == "--palette" ]; then
    get_palette $2
elif [ "$1" == "--full-palette" ]; then
    get_full_palette
elif [ "$1" == "--supported" ]; then
    get_supported
fi
