albert-repo:
    aptrepo.managed:
        - name: {{pillar['repos']['albert']}}
        - listfile_name: albert.list
        - signed_by: /etc/apt/keyrings/albert-archive-keyring.gpg
        - signing_key_url: https://download.opensuse.org/repositories/home:manuelschneid3r/Debian_12/Release.key
        - dearmor: True
        - require:
            - pkg: desktop-packages


albert:
    pkg.installed:
        - pkgs:
            - albert
        - require:
            - aptrepo: albert-repo


{% for user in pillar['users'] %}
albert-autostart-{{user}}:
    file.symlink:
        - name: /home/{{user}}/.config/autostart/albert.desktop
        - target: /usr/share/applications/albert.desktop
        - user: {{user}}
        - group: {{user}}
        - makedirs: True
        - require:
            - pkg: albert


albert-keyboard-shortcut-{{user}}:
    cmd.script:
        - source: salt://albert/add_keyboard_shortcut.sh
        - runas: {{user}}
        - unless: >
            gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings | 
              sed s/\'/\"/g | jq .[] | 
              xargs -n 1 printf "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:%s\n" |
              xargs -n 1 gsettings list-recursively | grep -q "albert toggle"
        - require:
            - file: albert-autostart-{{user}}
{% endfor %}
