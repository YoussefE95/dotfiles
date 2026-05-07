#!/bin/bash
palette=("${@}")
niri_conf="$HOME/.config/niri/config.kdl"

active="active-gradient from=\"#${palette[10]}\" to=\"#${palette[6]}\" angle=45"
inactive="inactive-color \"#${palette[1]}\""
urgent="urgent-color \"#${palette[4]}\""
cursor="xcursor-theme \"${palette[11]}\""
overview="backdrop-color \"${palette[0]}\""

sed -i "s/.*active-gradient.*/        $active/" $niri_conf
sed -i "s/.*inactive-color.*/        $inactive/" $niri_conf
sed -i "s/.*urgent-color.*/        $urgent/" $niri_conf
sed -i "s/.*xcursor-theme.*/    $cursor/" $niri_conf
sed -i "s/.*backdrop-color.*/    $overview/" $niri_conf
