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
albert-desktop-{{user}}:
   file.managed:
        - name: /home/{{user}}/.local/share/applications/albert.desktop
        - source: salt://albert/albert.desktop
        - user: {{user}}
        - group: {{user}}
        - makedirs: True
        - require:
            - pkg: albert


albert-autostart-{{user}}:
   file.symlink:
        - name: /home/{{user}}/.config/autostart/albert.desktop
        - target: /home/{{user}}/.local/share/applications/albert.desktop
        - user: {{user}}
        - group: {{user}}
        - makedirs: True
        - require:
            - file: albert-desktop-{{user}}


albert-keyboard-shortcut-{{user}}:
    file.managed:
        - name: {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "albert_keyboard_shortcut.py")}}
        - source: salt://albert/albert_keyboard_shortcut.py
        - user: {{user}}
        - group: {{user}}
        - mode: '0700'
        - makedirs: True
        - require:
            - file: albert-autostart-{{user}}


albert-keyboard-shortcut-startup-{{user}}:
    file.accumulated:
        - name: startup-scripts-{{user}}
        - filename: {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "startup.sh")}}
        - text: /usr/bin/python3 {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "albert_keyboard_shortcut.py")}} create
        - require_in:
            - file: startup-scripts-file-{{user}}
        - require:
            - file: albert-keyboard-shortcut-{{user}}
{% endfor %}

# vim: syntax=yaml
