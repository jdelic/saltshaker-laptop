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
    cmd.script:
        - name: albert_keyboard_shortcut.py create
        - source: salt://albert/albert_keyboard_shortcut.py
        - runas: {{user}}
        - require:
            - file: albert-autostart-{{user}}
{% endfor %}
