#!/bin/bash
palette=("${@}")

dest_dir="$HOME/.config/gtk-4.0"
dest_file="gtk.css"

output="$(cat << THEME
@define-color accent_bg_color #${palette[8]};
@define-color accent_fg_color #${palette[0]};
@define-color accent_color #${palette[8]};

@define-color destructive_bg_color #${palette[4]}; 
@define-color destructive_fg_color #${palette[0]};
@define-color destructive_color #${palette[4]};

@define-color success_bg_color #${palette[5]};
@define-color success_fg_color #${palette[2]};
@define-color success_color #${palette[5]};

@define-color warning_bg_color #${palette[6]};
@define-color warning_fg_color #${palette[2]};
@define-color warning_color #${palette[6]};

@define-color error_bg_color #${palette[4]};
@define-color error_fg_color #${palette[2]};
@define-color error_color #${palette[4]};

@define-color window_bg_color #${palette[0]};
@define-color window_fg_color #${palette[2]};

@define-color view_bg_color #${palette[1]};
@define-color view_fg_color #${palette[2]};

@define-color headerbar_bg_color #${palette[0]};
@define-color headerbar_fg_color #${palette[2]};
@define-color headerbar_backdrop_color @window_bg_color;
@define-color headerbar_shade_color #${palette[0]};

@define-color card_bg_color #${palette[1]};
@define-color card_fg_color #${palette[2]};
@define-color card_shade_color #${palette[1]};

@define-color popover_bg_color #${palette[1]};
@define-color popover_fg_color #${palette[2]};

.top-bar {
    color: #${palette[2]};
    background-color: #${palette[0]};
} 

placessidebar {
    color: #${palette[2]};
    background-color: #${palette[0]};
}

.navigation-sidebar {
    color: #${palette[2]};
    background-color: #${palette[0]};
}
THEME
)"

printf '%s' "$output" > "${dest_dir}/${dest_file}"

theme="${palette[11]}-${palette[12]}-${palette[13]}"

gsettings set org.gnome.desktop.interface gtk-theme "$theme" 
gsettings set org.gnome.desktop.interface color-scheme "prefer-${palette[12]}"
gsettings set org.gnome.desktop.interface icon-theme "${palette[14]}"
gsettings set org.gnome.desktop.interface font-name "JetBrains Mono SemiBold"
