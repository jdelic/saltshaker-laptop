#!/usr/bin/dbus-launch /usr/bin/python3
from gi.repository import Gio


def main():
    settings = Gio.Settings.new('org.gnome.desktop.wm.keybindings')

    def set_keybinding(key, value):
        settings.set_strv(key, value)
        print(f"Set {key} to {value}")

    # Switch workspace
    set_keybinding('switch-to-workspace-up', ['<Super>Page_Up', '<Control><Alt>Up'])
    set_keybinding('switch-to-workspace-down', ['<Super>Page_Down', '<Control><Alt>Down'])
    set_keybinding('switch-to-workspace-left', ['<Super><Alt>Left', '<Control><Alt>Left'])
    set_keybinding('switch-to-workspace-right', ['<Super><Alt>Right', '<Control><Alt>Right'])

    # Carry window over to workspace
    set_keybinding('move-to-workspace-up', ['<Super><Shift>Page_Up', '<Control><Shift><Alt>Up'])
    set_keybinding('move-to-workspace-down', ['<Super><Shift>Page_Down', '<Control><Shift><Alt>Down'])
    set_keybinding('move-to-workspace-left', ['<Super><Shift><Alt>Left', '<Control><Shift><Alt>Left'])
    set_keybinding('move-to-workspace-right', ['<Super><Shift><Alt>Right', '<Control><Shift><Alt>Right'])
    settings.apply()


if __name__ == "__main__":
    main()
