#!/usr/bin/env python3
import os
import sys
from gi.repository import Gio


if "GSETTINGS_SCHEMA_DIR" not in os.environ:
    print("Set GSETTINGS_SCHEMA_DIR first!")


def set_tray_icons_number(num_icons=8, icon_margin_horizontal=0, icon_padding_horizontal=0):
    # Schema ID for the "Tray Icons: Reloaded" extension
    # You might need to replace this with the correct schema ID for the extension
    schema_id = 'org.gnome.shell.extensions.trayIconsReloaded'
    
    # Initialize GSettings for the extension's schema
    try:
        settings = Gio.Settings.new(schema_id)
    except Exception as e:
        print(f"Failed to initialize schema {schema_id}: {str(e)}")
        sys.exit(1)

    # Set the number of tray icons
    settings.set_int('icons-limit', num_icons)
    settings.set_int('icon-margin-horizontal', icon_margin_horizontal)
    settings.set_int('icon-padding-horizontal', icon_padding_horizontal)
    settings.apply()
    print(f"Settings changed to: icons-limit={num_icons} "
          f"icon-margin-horizontal={icon_margin_horizontal} "
          f"icon-padding-horizontal={icon_padding_horizontal}")

set_tray_icons_number()

