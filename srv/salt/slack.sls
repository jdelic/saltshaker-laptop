slack-install:
    cmd.run:
        - name: /usr/bin/snap install --color=never slack
        - unless: /usr/bin/snap list --color=never | grep -q slack
        - require:
            - pkg: desktop-packages


# vim: syntax=yaml
