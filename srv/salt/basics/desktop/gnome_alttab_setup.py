#!/usr/bin/python3
from gi.repository import Gio


def main():
    settings = Gio.Settings.new('org.gnome.desktop.wm.keybindings')

    def set_keybinding(key, value):
        settings.set_strv(key, value) 
        print(f"Set {key} to {value}")

    # Disable "Switch Applications"
    set_keybinding('switch-applications', [])
    set_keybinding('switch-applications-backward', [])

    # Set "Switch windows" to Alt+Tab
    set_keybinding('switch-windows', ['<Alt>Tab'])
    set_keybinding('switch-windows-backward', ['<Shift><Alt>Tab'])
    settings.apply()
    Gio.Settings.sync()


if __name__ == "__main__":
    main()
