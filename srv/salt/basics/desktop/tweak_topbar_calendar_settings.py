#!/usr/bin/env /usr/bin/dbus-launch /usr/bin/python3
from gi.repository import Gio


def main():
    calendar_settings = Gio.Settings.new('org.gnome.desktop.calendar')
    interface_settings = Gio.Settings.new('org.gnome.desktop.interface')

    calendar_settings.set_boolean('show-weekdate', True)
    print("Week Numbers in Calendar enabled.")
    interface_settings.set_boolean('clock-show-date', True)
    print("Date in Top Bar Clock enabled.")


if __name__ == '__main__':
    main()
