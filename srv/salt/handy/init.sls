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
            - pkg: wtype


ydotool:
    pkg.installed:
        - fromrepo: trixie-backports
        - require:
            - pkg: desktop-packages
    cmd.run:
        - name: >
            sudo udevadm control --reload-rules;
            sudo udevadm trigger --subsystem-match=misc --attr-match=name=uinput
        - require:
            - pkg: ydotool
    service.running:
        - name: ydotoold
        - enable: True
        - require:
            - cmd: ydotool


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
    cmd.run:
        - name: /usr/bin/python3 {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "handy_keyboard_shortcut.py")}} create
        - runas: {{user}}
        - onlyif: /usr/bin/python3 {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "handy_keyboard_shortcut.py")}} check
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
{% endfor %}
