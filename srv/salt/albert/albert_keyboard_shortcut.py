#!/usr/bin/python3
import sys
from gi.repository import Gio


def get_existing_shortcuts():
    schema_id = 'org.gnome.settings-daemon.plugins.media-keys'
    path = '/org/gnome/settings-daemon/plugins/media-keys/'
    settings = Gio.Settings.new_with_path(schema_id, path)
    existing_shortcuts = settings.get_strv('custom-keybindings')
    return existing_shortcuts


def shortcut_exists(existing_shortcuts, shortcut_name):
    for path in existing_shortcuts:
        settings = Gio.Settings.new_with_path('org.gnome.settings-daemon.plugins.media-keys.custom-keybinding', path)
        if settings.get_string('name') == shortcut_name:
            return True
    return False


def create_new_shortcut(existing_shortcuts, new_shortcut_name, command, binding):
    new_shortcut_path = f"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom{len(existing_shortcuts)}/"
    new_shortcut_schema_id = 'org.gnome.settings-daemon.plugins.media-keys.custom-keybinding'
    new_shortcut_settings = Gio.Settings.new_with_path(new_shortcut_schema_id, new_shortcut_path)

    new_shortcut_settings.set_string('name', new_shortcut_name)
    new_shortcut_settings.set_string('command', command)
    new_shortcut_settings.set_string('binding', binding)

    # Add the new shortcut to the list and update the custom-keybindings setting
    updated_shortcuts = existing_shortcuts + [new_shortcut_path]
    settings = Gio.Settings.new('org.gnome.settings-daemon.plugins.media-keys')
    settings.set_strv('custom-keybindings', updated_shortcuts)
    Gio.Settings.sync()


def main(action):
    existing_shortcuts = get_existing_shortcuts()

    print(f"Found {len(existing_shortcuts)} existing shortcuts.\n")

    shortcut_name = "Albert"  # Define the shortcut name here

    if action == "check":
        if shortcut_exists(existing_shortcuts, shortcut_name):
            print(f"Shortcut '{shortcut_name}' exists.")
            sys.exit(1)  # Exit with non-zero exit code if shortcut exists
        else:
            print(f"Shortcut '{shortcut_name}' does not exist.")
            sys.exit(0)
    elif action == "create":
        if not shortcut_exists(existing_shortcuts, shortcut_name):
            create_new_shortcut(existing_shortcuts, shortcut_name, "albert toggle", "<Super>x")
            print("Shortcut created successfully.")
            sys.exit(0)
        print(f"Shortcut '{shortcut_name}' already exists.")
    else:
        print("Invalid action. Use 'check' or 'create'.")
        sys.exit(1)


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: python script.py <action>")
        print("Action can be 'check' or 'create'.")
        sys.exit(1)
    main(sys.argv[1])
