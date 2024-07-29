discord:
    file.managed:
        - name: /var/cache/salt/discord/discord.deb
        - source: 'https://discord.com/api/download?platform=linux&format=deb'
        - skip_verify: True
        - replace: False
        - makedirs: True
        - user: root
        - group: root
        - mode: '0644'
        - dir_mode: '0755'
    pkg.installed:
        - sources:
            - discord: /var/cache/salt/discord/discord.deb
        - onchanges:
            - file: discord
        - require:
            - pkg: desktop-packages
            - file: discord