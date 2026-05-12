#!/bin/bash
palette=("${@}")

dest_dir="$HOME/.local/share/color-schemes/"
dest_file="DynamicTheme.colors"

output="$(cat << THEME
[ColorEffects:Disabled]
Color=#${palette[3]}
ColorAmount=0.15000000000000002
ColorEffect=1
ColorAmount=0.42500000000000004
ColorEffect=2
ContrastAmount=0.1
ContrastEffect=1
IntensityAmount=-1
IntensityEffect=2

[ColorEffects:Inactive]
ChangeSelectionColor=true
Color=#${palette[3]}
ColorAmount=0.025
ColorEffect=2
ContrastAmount=0.1
ContrastEffect=2
Enable=false
IntensityAmount=0
IntensityEffect=0

[Colors:Button]
BackgroundAlternate=#${palette[1]}
BackgroundNormal=#${palette[1]}
DecorationFocus=#${palette[8]}
DecorationHover=#${palette[8]}
ForegroundActive=#${palette[2]}
ForegroundInactive=#${palette[2]}
ForegroundLink=#${palette[7]}
ForegroundNegative=#${palette[4]}
ForegroundNeutral=#${palette[6]}
ForegroundNormal=#${palette[2]}
ForegroundPositive=#${palette[5]}
ForegroundVisited=#${palette[8]}

[Colors:Complementary]
BackgroundAlternate=#${palette[0]}
BackgroundNormal=#${palette[0]}
DecorationFocus=#${palette[6]}
DecorationHover=#${palette[3]}
ForegroundActive=#${palette[2]}
ForegroundInactive=#${palette[3]}
ForegroundLink=#${palette[7]}
ForegroundNegative=#${palette[4]}
ForegroundNeutral=#${palette[6]}
ForegroundNormal=#${palette[2]}
ForegroundPositive=#${palette[5]}
ForegroundVisited=#${palette[8]}

[Colors:Header]
BackgroundAlternate=#${palette[1]}
BackgroundNormal=#${palette[1]}
DecorationFocus=#${palette[6]}
DecorationHover=#${palette[3]}
ForegroundActive=#${palette[2]}
ForegroundInactive=#${palette[3]}
ForegroundLink=#${palette[7]}
ForegroundNegative=#${palette[4]}
ForegroundNeutral=#${palette[6]}
ForegroundNormal=#${palette[2]}
ForegroundPositive=#${palette[5]}
ForegroundVisited=#${palette[8]}

[Colors:Selection]
BackgroundAlternate=#${palette[10]}
BackgroundNormal=#${palette[10]}
DecorationFocus=#${palette[6]}
DecorationHover=#${palette[3]}
ForegroundLink=#${palette[7]}
ForegroundInactive=#${palette[0]}
ForegroundActive=#${palette[2]}
ForegroundLink=#${palette[7]}
ForegroundNegative=#${palette[4]}
ForegroundNeutral=#${palette[6]}
ForegroundNormal=#${palette[0]}
ForegroundPositive=#${palette[5]}
ForegroundVisited=#${palette[8]}

[Colors:Tooltip]
BackgroundAlternate=#${palette[0]}
BackgroundNormal=#${palette[0]}
DecorationFocus=#${palette[6]}
DecorationHover=#${palette[3]}
ForegroundActive=#${palette[2]}
ForegroundInactive=#${palette[3]}
ForegroundLink=#${palette[7]}
ForegroundNegative=#${palette[4]}
ForegroundNeutral=#${palette[6]}
ForegroundNormal=#${palette[2]}
ForegroundPositive=#${palette[5]}
ForegroundVisited=#${palette[8]}

[Colors:View]
BackgroundAlternate=#${palette[0]}
BackgroundNormal=#${palette[0]}
DecorationFocus=#${palette[6]}
DecorationHover=#${palette[3]}
ForegroundActive=#${palette[2]}
ForegroundInactive=#${palette[3]}
ForegroundLink=#${palette[7]}
ForegroundNegative=#${palette[4]}
ForegroundNeutral=#${palette[6]}
ForegroundNormal=#${palette[2]}
ForegroundPositive=#${palette[5]}
ForegroundVisited=#${palette[8]}

[Colors:Window]
BackgroundAlternate=#${palette[1]}
BackgroundNormal=#${palette[1]}
DecorationFocus=#${palette[6]}
DecorationHover=#${palette[3]}
ForegroundActive=#${palette[2]}
ForegroundInactive=#${palette[3]}
ForegroundLink=#${palette[7]}
ForegroundNegative=#${palette[4]}
ForegroundNeutral=#${palette[6]}
ForegroundNormal=#${palette[2]}
ForegroundPositive=#${palette[5]}
ForegroundVisited=#${palette[8]}

[General]
ColorScheme=DynamicTheme
Name=Dynamic Theme
accentActiveTitlebar=false
shadeSortColumn=true

[KDE]
contrast=4

[WM]
activeBackground=#${palette[0]}
activeBlend=#${palette[2]}
activeForeground=#${palette[2]}
inactiveBackground=#${palette[0]}
inactiveBlend=#${palette[3]}
inactiveForeground=#${palette[3]}
THEME
)"

printf '%s' "$output" > "${dest_dir}${dest_file}"

# Icons
/usr/lib/plasma-changeicons "${palette[11]}"

# Cursors
plasma-apply-cursortheme "${palette[12]}"

# Color Scheme
plasma-apply-colorscheme "BreezeDark"
plasma-apply-colorscheme "DynamicTheme"
