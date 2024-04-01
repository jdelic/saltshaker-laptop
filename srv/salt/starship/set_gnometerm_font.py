#!/usr/bin/env python3
from gi.repository import Gio

gnome_dark_palette = ['#171421', '#c01c28', '#26a269', '#a2734c', '#12488b', '#a347ba', '#2aa1b3', '#d0cfcc', '#5e5c64', '#f66151', '#33da7a', '#e9ad0c', '#2a7bde', '#c061cb', '#33c7de', '#ffffff']
gnome_dark_colors = {
    "foreground": "#D0CFCC",
    "background": "#171421",
    "bold": "#000000",
}
green_on_black = {
    "foreground": "#00FF00",
    "background": "#000000",
    "bold": "#000000",
}


def set_gnome_terminal_font(font_name='DroidSansM Nerd Font Mono', font_size='10',
                            palette=None, colors=None):
    if palette is None:
        palette = gnome_dark_palette
    if colors is None:
        colors = gnome_dark_colors
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
    settings.set_boolean('use-theme-colors', False)
    # this palette is equivalent to "GNOME dark" built-in
    settings.set_strv('palette', palette) 
    settings.set_string('foreground-color', colors['foreground'])
    settings.set_string('background-color', colors['background'])
    settings.set_string('bold-color', colors['bold'])
    settings.apply()
    print(f"Gnome Terminal font set to: {font_name} in {font_size}")


def set_gnome_terminal_theme_variant(variant="dark"):
    settings = Gio.Settings.new('org.gnome.Terminal.Legacy.Settings')
    settings.set_enum('theme-variant', 2) 
    settings.apply()
    print("Gnome Terminal dark mode activated")

# You can use the `fc-list` command in the terminal to list all fonts and find the exact name
set_gnome_terminal_font(font_size=12)
set_gnome_terminal_theme_variant()

