starship-install:
    cmd.script:
        - name: install.sh -y
        - source: https://starship.rs/install.sh
        - runas: root
        - creates: /usr/local/bin/starship
        - require:
            - pkg: desktop-packages


{% for user in pillar['users'] %}
{{user}}-droidsans-nerdfont:
    archive.extracted:
        - name: {{salt['file.join'](salt['user.info'](user).home, ".local", "share", "fonts", "droidsans-nerdfont")}}
        - source: {{pillar['downloads']['droidsans-nerdfont']['url']}}
        - source_hash: {{pillar['downloads']['droidsans-nerdfont']['hash']}}
        - user: {{user}}
        - enforce_toplevel: False
        - require:
            - file: {{user}}-fonts-dir
            - pkg: desktop-packages
        - require_in:
            - cmd: {{user}}-fccache


{{user}}-droidsans-activate:
    file.managed:
        - name: {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "set_gnometerm_font.py")}}
        - source: salt://starship/set_gnometerm_font.py
        - user: {{user}}
        - group: {{user}}
        - mode: '0700'
        - makedirs: True
        - require:
            - archive: {{user}}-droidsans-nerdfont
            - cmd: {{user}}-fccache


startup-{{user}}-droidsans-activate:
    file.accumulated:
        - name: startup-scripts-{{user}}
        - filename: {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "startup.sh")}}
        - text: /usr/bin/python3 {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "set_gnometerm_font.py")}}
        - require_in:
            - file: startup-scripts-file-{{user}}
        - require:
            - file: {{user}}-droidsans-activate
{% endfor %}

# vim: syntax=yaml
