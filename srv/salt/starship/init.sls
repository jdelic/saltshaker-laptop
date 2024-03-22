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
        - require_in:
            - cmd: {{user}}-fccache


{{user}}-droidsans-activate:
    cmd.script:
        - name: set_gnometerm_font.py
        - source: salt://starship/set_gnometerm_font.py
        - runas: {{user}}
        - require:
            - archive: {{user}}-droidsans-nerdfont
            - cmd: {{user}}-fccache
{% endfor %}

