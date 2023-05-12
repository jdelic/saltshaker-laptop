discord:
    file.managed:
        - name: /var/cache/salt/discord/discord.deb
        - source: 'https://discord.com/api/download?platform=linux&format=deb'
        - makedirs: True
        - user: root
        - group: root
        - mode: '0600'
    pkg.installed:
        - sources:
            - discord: /var/cache/salt/discord/discord.deb
        - require:
            - pkg: desktop-packages
            - file: discord