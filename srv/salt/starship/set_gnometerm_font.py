#!/usr/bin/env python3
from gi.repository import Gio

def set_gnome_terminal_font(font_name='DroidSansM Nerd Font Mono', font_size='10'):
    # Obtain the list of profiles
    profiles_list = Gio.Settings.new('org.gnome.Terminal.ProfilesList')
    profile_list = profiles_list.get_strv('list')

    if not profile_list:
        print("No profiles found. Are you sure Gnome Terminal is installed?")
        return

    # Assuming the first profile is the default one. Adjust if necessary.
    default_profile_path = f"/org/gnome/terminal/legacy/profiles:/:{profile_list[0]}/"
    settings = Gio.Settings.new_with_path('org.gnome.Terminal.Legacy.Profile', default_profile_path)

    # Set the font for the Gnome Terminal profile
    settings.set_string('font', f"{font_name} {font_size}")
    settings.set_boolean('use-system-font', False)
    settings.apply()
    print(f"Gnome Terminal font set to: {font_name} in {font_size}")

# You can use the `fc-list` command in the terminal to list all fonts and find the exact name
set_gnome_terminal_font(font_size=12)

