#!/usr/bin/env /usr/bin/dbus-launch /usr/bin/python3
from gi.repository import Gio


def set_keybinding(schema_id, key, value):
    settings = Gio.Settings.new(schema_id)
    settings.set_strv(key, value)
    settings.apply()
    print(f"Set {key} to {value} in {schema_id}")


def main():
    # Switch workspace
    set_keybinding('org.gnome.desktop.wm.keybindings', 'switch-to-workspace-up', ['<Super>Page_Up', '<Control><Alt>Up'])
    set_keybinding('org.gnome.desktop.wm.keybindings', 'switch-to-workspace-down', ['<Super>Page_Down', '<Control><Alt>Down'])
    set_keybinding('org.gnome.desktop.wm.keybindings', 'switch-to-workspace-left', ['<Super><Alt>Left', '<Control><Alt>Left'])
    set_keybinding('org.gnome.desktop.wm.keybindings', 'switch-to-workspace-right', ['<Super><Alt>Right', '<Control><Alt>Right'])

    # Carry window over to workspace
    set_keybinding('org.gnome.desktop.wm.keybindings', 'move-to-workspace-up', ['<Super><Shift>Page_Up', '<Control><Shift><Alt>Up'])
    set_keybinding('org.gnome.desktop.wm.keybindings', 'move-to-workspace-down', ['<Super><Shift>Page_Down', '<Control><Shift><Alt>Down'])
    set_keybinding('org.gnome.desktop.wm.keybindings', 'move-to-workspace-left', ['<Super><Shift><Alt>Left', '<Control><Shift><Alt>Left'])
    set_keybinding('org.gnome.desktop.wm.keybindings', 'move-to-workspace-right', ['<Super><Shift><Alt>Right', '<Control><Shift><Alt>Right'])



if __name__ == "__main__":
    main()
