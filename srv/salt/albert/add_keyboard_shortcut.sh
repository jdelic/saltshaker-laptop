#!/bin/bash
    
has_gsettings=$(which gsettings)
if [[ ! -z "$has_gsettings" ]]; then
    function add_keyboard_shortcut ()
    {
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
        if [[ ! -z "$1" ]] && [[ ! -z "$2" ]] && [[ ! -z "$3" ]]; then
            printf "\nFound %s existing custom shortcuts.\n\n" "$existing_shortcut_count"
            printf 'Setting new custom keyboard shortcut "%s" => %s' "$1" "$2"
            gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$new_shortcut_index/ name "$1"
            gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$new_shortcut_index/ command "$2"
            gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$new_shortcut_index/ binding "$3"
            gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "${declaration_string}"
        else
            printf "\n\nYou are missing input arguments.\n\nThis command requires 3 arguments...\n\nSyntax is add_keyboard_shortcut 'Name' 'Command' 'Shorcut'\n\n\nFor example\n\n  add_keyboard_shortcut 'Open Nautilus' 'nautilus' '<Control>F3'\n\n\n\n\n\nCommon Key Abbreviations:\n\n";
            printf 'Super key:                 <Super>\nControl key:               <Primary> or <Control>\nAlt key:                   <Alt>\nShift key:                 <Shift>\nnumbers:                   1 (just the number)\nSpacebar:                  space\nSlash key:                 slash\nAsterisk key:              asterisk (so it would need `<Shift>` as well)\nAmpersand key:             ampersand (so it would need <Shift> as well)\n\na few numpad keys:\nNumpad divide key (`/`):   KP_Divide\nNumpad multiply (Asterisk):KP_Multiply\nNumpad number key(s):      KP_1\nNumpad `-`:                KP_Subtract\n\n\n\nList all gsettings keys:\n  gsettings list-recursively';
            return -1;
        fi
    }
fi

add_keyboard_shortcut $*
