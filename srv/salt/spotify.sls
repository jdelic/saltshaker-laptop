spotify:
    cmd.run:
        - name: /usr/bin/snap install --color=never spotify
        - unless: /usr/bin/snap list --color=never | grep -q spotify
        - require:
            - pkg: desktop-packages


# vim: syntax=yaml
