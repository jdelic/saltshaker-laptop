starship-install:
    cmd.run:
        - name: snap install --edge --color=never starship
        - unless: /usr/bin/snap list --color=never | grep -q starship
        - require:
            - pkg: desktop-packages
