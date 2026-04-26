# Handy voice dictation
handy:
    file.managed:
        - name: /var/cache/salt/handy/handy.deb
        - source: https://github.com/cjpais/Handy/releases/download/v0.8.2/Handy_0.8.2_amd64.deb
        - source_hash: sha256=46d207cad5fc5918c6fadcc4ce164a7cdb616250bc123a22459165e3693e3250
        - replace: False
        - makedirs: True
        - user: root
        - group: root
        - mode: '0644'
        - dir_mode: '0755'
    pkg.installed:
        - sources:
            - handy: /var/cache/salt/handy/handy.deb
        - onchanges:
            - file: handy
        - require:
            - pkg: desktop-packages
            - file: handy


ydotool:
    pkg.installed:
        - fromrepo: trixie-backports
        - require:
            - pkg: desktop-packages
    cmd.run:
        - name: >
            udevadm control --reload-rules;
            udevadm trigger --subsystem-match=misc --attr-match=name=uinput
        - require:
            - pkg: ydotool


{% for user in pillar['users'] %}
handy-keyboard-shortcut-{{user}}:
    file.managed:
        - name: {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "handy_keyboard_shortcut.py")}}
        - source: salt://handy/handy_keyboard_shortcut.py
        - user: {{user}}
        - group: {{user}}
        - mode: '0700'
        - makedirs: True
        - require:
            - pkg: handy


handy-keyboard-shortcut-startup-{{user}}:
    file.accumulated:
        - name: startup-scripts-{{user}}
        - filename: {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "handy_keyboard_shortcut.py")}}
        - text: /usr/bin/python3 {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "handy_keyboard_shortcut.py")}} create
        - require_in:
              - file: startup-scripts-file-{{user}}
        - require:
              - file: handy-keyboard-shortcut-{{user}}


add-{{user}}-into-input:
    user.present:
        - name: {{user}}
        - optional_groups:
            - input
        - remove_groups: False
        - require:
            - pkg: desktop-packages


systemd-enable-handy-ydotoold-{{user}}:
    cmd.run:
         - name: systemctl --machine={{user}}@.host --user enable ydotool.service
         - runas: {{user}}
         - require:
             - cmd: ydotool
             - user: add-{{user}}-into-input


handy-autostart-{{user}}:
   file.symlink:
        - name: /home/{{user}}/.config/autostart/Handy.desktop
        - target: /usr/share/applications/Handy.desktop
        - user: {{user}}
        - group: {{user}}
        - makedirs: True
        - require:
            - pkg: handy
{% endfor %}
