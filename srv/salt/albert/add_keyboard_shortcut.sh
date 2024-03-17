#!/bin/bash
    
has_gsettings=$(which gsettings)
if [[ -z "$has_gsettings" ]]; then
    echo "this script needs the gsettings executable"
fi
existing_shortcut_string=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)
exst_str_len=$((${#existing_shortcut_string}))
if (( $exst_str_len < 9 )); then
    existing_shortcut_count=0
else
    IFS=', ' read -ra existing_shortcut_array <<< "$existing_shortcut_string"
    existing_shortcut_count="${#existing_shortcut_array[@]}"
fi
new_shortcut_index=$(("$existing_shortcut_count"))
declaration_string=' ['
for (( i=0; i<="$existing_shortcut_count"; i++ )); do
    if (( $i == 0 )); then
        declaration_string="$declaration_string""'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/'"
    else
        declaration_string="$declaration_string"", '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$i/'"
    fi
done
declaration_string="$declaration_string"']'

printf "\nFound %s existing custom shortcuts.\n\n" "$existing_shortcut_count"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$new_shortcut_index/ name "Albert"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$new_shortcut_index/ command "albert toggle"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$new_shortcut_index/ binding "<Super>x"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "${declaration_string}"
echo "${declaration_string}"
