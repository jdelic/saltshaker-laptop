#!/usr/bin/env python3
from gi.repository import Gio


def set_keybinding(schema_id, key, value):
    settings = Gio.Settings.new(schema_id)
    settings.set_strv(key, value)
    settings.apply()
    print(f"Set {key} to {value} in {schema_id}")


def main():
    # Disable "Switch Applications"
    set_keybinding('org.gnome.desktop.wm.keybindings', 'switch-applications', [])
    set_keybinding('org.gnome.desktop.wm.keybindings', 'switch-applications-backward', [])

    # Set "Switch windows" to Alt+Tab
    set_keybinding('org.gnome.desktop.wm.keybindings', 'switch-windows', ['<Alt>Tab'])
    set_keybinding('org.gnome.desktop.wm.keybindings', 'switch-windows-backward', ['<Shift><Alt>Tab'])


if __name__ == "__main__":
    main()
